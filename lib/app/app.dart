import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/design_system/app_theme.dart';
import '../core/config/app_constants.dart';
import 'router/app_router.dart';

/// Widget principal de la aplicación
class FcfColombiaApp extends ConsumerWidget {
  const FcfColombiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
