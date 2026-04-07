import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// Sealed union of every error the app surfaces from networking + client-side
/// validation. Repositories, providers, and UI should only ever throw or
/// expose [AppException] — never raw `DioException` or untyped objects.
@freezed
sealed class AppException with _$AppException implements Exception {
  const AppException._();

  /// Connection failure, timeout, DNS, no internet, TLS handshake, or 5xx
  /// Binance outage. [retriable] is true for transient server-side issues
  /// (5xx) and false for offline / DNS / TLS / cancelled requests.
  const factory AppException.network({
    String? message,
    @Default(false) bool retriable,
  }) = NetworkException;

  /// API key invalid, missing permission, or 401. Requires re-login.
  /// Maps `-2014`, `-2015`, HTTP 401.
  const factory AppException.auth({required String message, int? code}) =
      AuthException;

  /// HTTP 429 or `-1003`. Distinct from [IpBanException].
  const factory AppException.rateLimit({
    required String message,
    int? retryAfterSeconds,
    int? code,
  }) = RateLimitException;

  /// HTTP 418. Hard-stop. The IP is banned by Binance.
  const factory AppException.ipBan({
    required String message,
    DateTime? bannedUntil,
  }) = IpBanException;

  /// `-1022` invalid signature — never silently retry, force re-login.
  const factory AppException.invalidSignature({String? message}) =
      InvalidSignatureException;

  /// `-1021` timestamp outside recvWindow — used by SigningInterceptor to
  /// trigger a one-shot resync + retry.
  const factory AppException.clockSkew({String? message}) = ClockSkewException;

  /// Client-side order validation failure (tick size, lot size, min notional,
  /// price bounds, etc.). Raised by trade providers BEFORE the request is
  /// sent. Never produced by the error interceptor.
  const factory AppException.filterViolation({
    required String filter,
    required String message,
    String? symbol,
  }) = FilterViolationException;

  /// Any other Binance error envelope `{code, msg}` we don't model explicitly.
  const factory AppException.binanceApi({
    required int code,
    required String message,
    int? httpStatusCode,
  }) = BinanceApiException;

  /// Catch-all for unexpected failures.
  const factory AppException.unknown({String? message}) = UnknownException;

  /// Human-readable display string.
  String get displayMessage => switch (this) {
    NetworkException(:final message) =>
      message ?? 'Network error. Check your connection.',
    AuthException(:final message) => message,
    RateLimitException(:final message) => message,
    IpBanException(:final message) => message,
    InvalidSignatureException(:final message) =>
      message ?? 'Invalid API signature.',
    ClockSkewException(:final message) =>
      message ?? 'Device clock out of sync with Binance.',
    FilterViolationException(:final filter, :final message) =>
      '$filter: $message',
    BinanceApiException(:final message) => message,
    UnknownException(:final message) => message ?? 'Unknown error.',
  };
}
