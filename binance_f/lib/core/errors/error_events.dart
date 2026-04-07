import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_exception.dart';

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
