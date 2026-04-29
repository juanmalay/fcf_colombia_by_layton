import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/utils/logger.dart';

void main() {
  AppLogger.info('Iniciando aplicación FCF Colombia');

  runApp(
    const ProviderScope(
      child: FcfColombiaApp(),
    ),
  );
}
