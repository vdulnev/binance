import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_exception.dart';

/// # Error event convention (post-fpdart refactor)
///
/// Repositories return `TaskEither<AppException, T>`. Errors are therefore
/// values, not thrown exceptions, so they will **never** become `AsyncError`
/// on their own. To keep `AppErrorObserver` and the existing UI surfaces
/// working, the convention across the app is:
///
///   **Notifiers fold the `Left` branch of every repository `TaskEither` into
///   `AsyncError<T>` at the notifier boundary.**
///
/// Concretely, an `AsyncNotifier`'s action method should look like:
///
/// ```dart
/// final result = await _repository.someCall().run();
/// state = result.fold(
///   (err) => AsyncError(err, StackTrace.current),
///   (value) => AsyncData(value),
/// );
/// ```
///
/// `AppErrorObserver` then picks the `AsyncError` up via `didUpdateProvider`
/// and pushes the `AppException` into [errorEventsControllerProvider]. The
/// app shell listens on [errorEventsProvider] via `ref.listen` and routes
/// each event to a snackbar / dialog / re-login flow via `errorActionFor`.
///
/// `Notifier`s that don't expose `AsyncValue` (e.g. `AuthNotifier` which
/// owns its own sealed state union) push directly into the controller via
/// `ref.read(errorEventsControllerProvider).add(err)` after folding their
/// own state. Either way, **no repository ever throws** and the controller
/// is the single funnel for cross-cutting error UX.

/// Holds the global broadcast controller for [AppException] events.
/// Lives at the root of the Riverpod graph; the app shell listens to its
/// [Stream] and the [AppErrorObserver] pushes events into its [Sink].
final errorEventsControllerProvider = Provider<StreamController<AppException>>((
  ref,
) {
  final controller = StreamController<AppException>.broadcast();
  ref.onDispose(controller.close);
  return controller;
});

/// Stream of cross-cutting errors. UI subscribes via `ref.listen`.
final errorEventsProvider = Provider<Stream<AppException>>((ref) {
  return ref.watch(errorEventsControllerProvider).stream;
});

/// Riverpod observer that forwards every `AsyncError<AppException>` from any
/// notifier into the global error event stream. Mount it on the root
/// `ProviderScope`.
///
/// Notifiers that produce errors must surface them as `AsyncError` (the
/// convention documented at the top of this file) so this observer can pick
/// them up. `AsyncNotifier`s do this by folding the `Left` branch of a
/// `TaskEither` into `AsyncError`. Notifiers with custom state shapes push
/// directly via [errorEventsControllerProvider].
final class AppErrorObserver extends ProviderObserver {
  AppErrorObserver(this._container);

  final ProviderContainer _container;

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (newValue is AsyncError) {
      final err = newValue.error;
      if (err is AppException) {
        final controller = _container.read(errorEventsControllerProvider);
        if (!controller.isClosed) controller.add(err);
      }
    }
  }
}
