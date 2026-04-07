import '../models/app_exception.dart';
import 'error_action.dart';

/// Pure mapping from a domain error to a UI action. Keeping this pure makes
/// it trivial to test and lets us decide UI behavior in one place rather than
/// scattering `switch` statements across screens.
ErrorAction errorActionFor(AppException e) {
  return switch (e) {
    AuthException(:final message) => ErrorAction.forceRelogin(message),
    InvalidSignatureException() => const ErrorAction.forceRelogin(
      'Invalid API signature — please log in again.',
    ),
    IpBanException(:final message, :final bannedUntil) => ErrorAction.blockUi(
      bannedUntil == null
          ? message
          : '$message (until ${bannedUntil.toIso8601String()})',
    ),
    RateLimitException(:final message) => ErrorAction.showSnackbar(message),
    FilterViolationException(:final filter, :final message) =>
      ErrorAction.showSnackbar('$filter: $message'),
    NetworkException(:final message) => ErrorAction.showSnackbar(
      message ?? 'Network error.',
    ),
    ClockSkewException(:final message) => ErrorAction.showSnackbar(
      message ?? 'Device clock out of sync with Binance.',
    ),
    BinanceApiException(:final message) => ErrorAction.showSnackbar(message),
    UnknownException(:final message) => ErrorAction.showSnackbar(
      message ?? 'Unknown error.',
    ),
  };
}
