import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_service.dart';
import '../config/environment.dart';

/// Providers globales de inyección de dependencias

/// DioService - cliente HTTP
final dioServiceProvider = Provider<DioService>((ref) {
  return DioService();
});

/// Configuración del ambiente
final environmentProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig.current;
});

/// Providers para autenticación (placeholder para futuro)
final authTokenProvider = StateProvider<String?>((ref) {
  return null; // Se actualizará cuando haya login
});
