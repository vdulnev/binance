import 'package:auto_route/auto_route.dart';

import '../auth/session_manager.dart';
import 'app_router.dart';

/// Redirects to [LoginRoute] when no credentials are stored. Used to gate the
/// home / portfolio / trading screens behind a valid session.
class AuthGuard extends AutoRouteGuard {
  AuthGuard({required SessionManager sessionManager})
    : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isValid = await _sessionManager.isSessionValid();
    if (isValid) {
      resolver.next();
      return;
    }
    await router.replaceAll([const LoginRoute()]);
  }
}
