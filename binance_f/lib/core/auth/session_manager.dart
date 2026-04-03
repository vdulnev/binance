import 'token_manager.dart';

class SessionManager {
  SessionManager({required TokenManager tokenManager})
    : _tokenManager = tokenManager;

  final TokenManager _tokenManager;

  Future<bool> isSessionValid() => _tokenManager.hasTokens();

  Future<void> invalidateSession() => _tokenManager.clearTokens();
}
