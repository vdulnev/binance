import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

import '../../features/auth/data/auth_repository.dart';
import '../api/binance_client.dart';
import '../auth/session_manager.dart';
import '../auth/token_manager.dart';
import '../logging/app_talker.dart';
import '../router/app_router.dart';
import '../router/auth_guard.dart';
import '../security/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Logging
  sl.registerLazySingleton<Talker>(createAppTalker);

  // Security
  sl.registerLazySingleton<SecureStorageService>(
    FlutterSecureStorageService.new,
  );

  // Auth
  sl.registerLazySingleton<TokenManager>(
    () => TokenManager(storage: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<SessionManager>(
    () => SessionManager(tokenManager: sl<TokenManager>()),
  );

  // API
  sl.registerLazySingleton<Dio>(
    () => createBinanceClient(
      talker: sl<Talker>(),
      storage: sl<SecureStorageService>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => BinanceAuthRepository(dio: sl<Dio>()),
  );

  // Router
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(authGuard: AuthGuard(sessionManager: sl<SessionManager>())),
  );
}
