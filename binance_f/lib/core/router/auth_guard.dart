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
    // Treat any failure (storage unreachable, etc.) as "not logged in" and
    // route to login. We never want a guard exception to leave navigation in
    // a half-resolved state.
    final result = await _sessionManager.isSessionValid().run();
    final valid = result.getOrElse((_) => false);
    if (valid) {
      resolver.next();
      return;
    }
    await router.replaceAll([const LoginRoute()]);
  }
}
