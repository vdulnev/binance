import 'package:fpdart/fpdart.dart';

import '../models/app_exception.dart';
import 'credentials_manager.dart';

class SessionManager {
  SessionManager({required CredentialsManager credentialsManager})
    : _credentialsManager = credentialsManager;

  final CredentialsManager _credentialsManager;

  TaskEither<AppException, bool> isSessionValid() =>
      _credentialsManager.hasCredentials();

  TaskEither<AppException, Unit> invalidateSession() =>
      _credentialsManager.clearCredentials();
}
