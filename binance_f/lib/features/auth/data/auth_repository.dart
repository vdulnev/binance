import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/models/app_exception.dart';

abstract class AuthRepository {
  /// Verifies API credentials by calling a signed account endpoint
  /// (`GET /api/v3/account`). Returns `Right(unit)` on success and
  /// `Left(AppException)` on any failure.
  TaskEither<AppException, Unit> verifyCredentials();
}

/// Resolves the spot [Dio] lazily on every call so that an env switch
/// (which rebuilds the underlying Dio inside [EnvManager]) is observed
/// without re-registering the repository in get_it.
typedef DioProvider = Dio Function();

class BinanceAuthRepository implements AuthRepository {
  BinanceAuthRepository({
    required DioProvider dio,
    SessionManager? sessionManager,
  }) : _dio = dio,
       _sessionManager = sessionManager;

  final DioProvider _dio;
  final SessionManager? _sessionManager;

  @override
  TaskEither<AppException, Unit> verifyCredentials() {
    // EC-15: register a CancelToken with SessionManager so a logout
    // mid-verification aborts the request instead of letting it hit the
    // server with a stale signature. The token lives only for the
    // duration of the call; we always unregister at the end via fpdart's
    // `.bimap` so success and failure both clean up.
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, Unit>.tryCatch(
      () async {
        // GET /api/v3/account is a SIGNED (USER_DATA) endpoint.
        // The SigningInterceptor adds the API key header, timestamp,
        // and HMAC-SHA256 signature automatically.
        await _dio().get<Map<String, dynamic>>(
          '/api/v3/account',
          cancelToken: cancelToken,
        );
        return unit;
      },
      (err, _) {
        // ErrorInterceptor wraps DioException.error as AppException.
        // Anything else (e.g. parser failure) becomes Unknown.
        if (err is AppException) return err;
        if (err is DioException && err.error is AppException) {
          return err.error! as AppException;
        }
        return AppException.unknown(message: err.toString());
      },
    ).bimap(
      (l) {
        _sessionManager?.unregisterCancelToken(cancelToken);
        return l;
      },
      (r) {
        _sessionManager?.unregisterCancelToken(cancelToken);
        return r;
      },
    );
  }
}
