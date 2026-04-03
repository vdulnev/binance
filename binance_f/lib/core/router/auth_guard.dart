import 'package:auto_route/auto_route.dart';

import '../auth/session_manager.dart';
import 'app_router.dart';

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
    } else {
      resolver.next(false);
      router.push(const LoginRoute());
    }
  }
}
