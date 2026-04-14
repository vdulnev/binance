import 'package:flutter/material.dart';

import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';

class BinanceApp extends StatelessWidget {
  const BinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl<AppRouter>();
    return MaterialApp.router(
      title: 'Binance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF0B90B),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      routerConfig: router.config(),
    );
  }
}
