import 'credentials_manager.dart';

class SessionManager {
  SessionManager({required CredentialsManager credentialsManager})
    : _credentialsManager = credentialsManager;

  final CredentialsManager _credentialsManager;

  Future<bool> isSessionValid() => _credentialsManager.hasCredentials();

  Future<void> invalidateSession() => _credentialsManager.clearCredentials();
}
