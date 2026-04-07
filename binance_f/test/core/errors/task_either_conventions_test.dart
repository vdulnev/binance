import 'package:binance_f/core/errors/error_events.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

/// Stand-in for a real repository — surfaces a `TaskEither` so the test can
/// inject either branch without touching Dio.
class _FakeRepository {
  _FakeRepository(this._result);
  final TaskEither<AppException, int> _result;
  TaskEither<AppException, int> fetch() => _result;
}

/// Minimal `Notifier<AsyncValue<int>>` that follows the documented
/// convention: fold the `Left` of a repository `TaskEither` into
/// `AsyncError` so that `AppErrorObserver` can pick it up.
///
/// We use a plain `Notifier<AsyncValue<int>>` rather than `AsyncNotifier`
/// because we want to assign `AsyncError` directly without the framework
/// observing an unhandled async error from a throwing `build()`.
class _NumberNotifier extends Notifier<AsyncValue<int>> {
  _NumberNotifier(this._repo);
  final _FakeRepository _repo;

  @override
  AsyncValue<int> build() => const AsyncValue.loading();

  Future<void> load() async {
    final result = await _repo.fetch().run();
    state = result.fold(
      (err) => AsyncError<int>(err, StackTrace.current),
      AsyncData<int>.new,
    );
  }
}

NotifierProvider<_NumberNotifier, AsyncValue<int>> _makeProvider(
  _FakeRepository repo,
) => NotifierProvider<_NumberNotifier, AsyncValue<int>>(
  () => _NumberNotifier(repo),
);

void main() {
  group('TaskEither error convention', () {
    test('repository Left(AppException.network) lands as AsyncError and '
        'reaches errorEventsProvider', () async {
      final provider = _makeProvider(
        _FakeRepository(
          TaskEither.left(const AppException.network(message: 'no internet')),
        ),
      );

      final lateObserver = _LateObserver();
      final container = ProviderContainer(observers: [lateObserver]);
      addTearDown(container.dispose);
      lateObserver.delegate = AppErrorObserver(container);

      final received = <AppException>[];
      final sub = container.read(errorEventsProvider).listen(received.add);
      addTearDown(sub.cancel);

      await container.read(provider.notifier).load();

      final state = container.read(provider);
      expect(state, isA<AsyncError<int>>());
      expect((state as AsyncError<int>).error, isA<NetworkException>());

      // Give the broadcast stream a microtask to deliver.
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.single, isA<NetworkException>());
    });

    test(
      'repository Right(value) reaches AsyncData and fires no event',
      () async {
        final provider = _makeProvider(_FakeRepository(TaskEither.right(42)));

        final lateObserver = _LateObserver();
        final container = ProviderContainer(observers: [lateObserver]);
        addTearDown(container.dispose);
        lateObserver.delegate = AppErrorObserver(container);

        final received = <AppException>[];
        final sub = container.read(errorEventsProvider).listen(received.add);
        addTearDown(sub.cancel);

        await container.read(provider.notifier).load();

        final state = container.read(provider);
        expect(state, isA<AsyncData<int>>());
        expect((state as AsyncData<int>).value, 42);

        await Future<void>.delayed(Duration.zero);
        expect(received, isEmpty);
      },
    );
  });
}

/// Forwards observer events to a delayed-bound delegate. We need this because
/// `AppErrorObserver` requires a `ProviderContainer` to construct, but
/// `ProviderContainer` requires its observer list at construction time.
final class _LateObserver extends ProviderObserver {
  AppErrorObserver? delegate;

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    delegate?.didUpdateProvider(context, previousValue, newValue);
  }
}
