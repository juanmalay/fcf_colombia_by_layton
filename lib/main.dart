import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'core/config/app_theme.dart';

void main() {
   debugPaintSizeEnabled = false;
  debugPaintBaselinesEnabled = false;
  debugPaintPointersEnabled = false;
  debugRepaintRainbowEnabled = false;

  runApp(const ProviderScope(child: FcfColombiaApp()));
}

class FcfColombiaApp extends ConsumerWidget {
  const FcfColombiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter.router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'FCF Colombia by Layton',
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
