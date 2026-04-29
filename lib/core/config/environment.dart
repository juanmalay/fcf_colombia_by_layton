import 'dart:io';

/// Configuración de entornos (development, staging, production)
enum Environment { dev, staging, prod }

class EnvironmentConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool useMockData;
  final bool enableLogging;

  const EnvironmentConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.useMockData,
    required this.enableLogging,
  });

  /// Development: mock data, logging enabled
  /// Detecta automáticamente plataforma para usar la URL correcta del backend
  static const EnvironmentConfig development = EnvironmentConfig(
    environment: Environment.dev,
    apiBaseUrl: 'http://localhost:8080', // Se sobrescribe en getDevelopmentConfig
    useMockData: false,
    enableLogging: true,
  );

  /// Staging: real API, logging enabled
  static const EnvironmentConfig staging = EnvironmentConfig(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging.api.fcf-app.com',
    useMockData: false,
    enableLogging: true,
  );

  /// Production: real API, logging disabled
  static const EnvironmentConfig production = EnvironmentConfig(
    environment: Environment.prod,
    apiBaseUrl: 'https://api.fcf-app.com',
    useMockData: false,
    enableLogging: false,
  );

  /// ============================================================================
  /// CONFIGURACIÓN DE RED LOCAL
  /// ============================================================================
  /// IP del PC en la red local (para conectar desde dispositivo físico Android/iOS)
  /// CAMBIAR AQUÍ si tu PC tiene otra IP en la red
  /// Ejemplo: '192.168.1.100', '192.168.0.5', '10.0.0.50', etc.
  static const String _localNetworkIp = '192.168.1.2';

  /// IP para Android Emulator (alias que apunta al host)
  /// NO CAMBIAR - es especial del emulador
  static const String _androidEmulatorIp = '10.0.2.2';

  /// Retorna configuración de development adaptada a la plataforma
  /// 
  /// Mapeo:
  /// - Web (Chrome/Firefox): localhost:8080
  /// - Android Emulator: 10.0.2.2:8080
  /// - Android Físico: 192.168.1.2:8080 (o tu IP LAN)
  /// - iOS Simulator: localhost:8080
  /// - iOS Físico: 192.168.1.2:8080 (o tu IP LAN)
  static EnvironmentConfig getDevelopmentConfig() {
    String baseUrl;

    if (Platform.isAndroid) {
      // DISPOSITIVO FÍSICO: Usa IP local
      // EMULADOR: Descomentar la línea con _androidEmulatorIp y comentar _localNetworkIp
      baseUrl = 'http://$_localNetworkIp:8080';
      // baseUrl = 'http://$_androidEmulatorIp:8080'; // Descomentar para emulator
    } else if (Platform.isIOS) {
      // DISPOSITIVO FÍSICO & SIMULATOR: Ambos pueden usar IP local
      // SIMULATOR TRADICIONAL: Can also use localhost
      baseUrl = 'http://$_localNetworkIp:8080';
      // Para iOS Simulator exclusivamente: baseUrl = 'http://localhost:8080';
    } else {
      // Web, Mac, Linux, Windows
      baseUrl = 'http://localhost:8080';
    }

    return EnvironmentConfig(
      environment: Environment.dev,
      apiBaseUrl: baseUrl,
      useMockData: false,
      enableLogging: true,
    );
  }

  /// Configuración actual (default: development)
  /// Usar getDevelopmentConfig() para desarrollo con platform-awareness
  /// O usar production para build final
  static EnvironmentConfig current = getDevelopmentConfig();

  /// Método para cambiar ambiente en runtime (útil para QA/testing)
  static void setEnvironment(EnvironmentConfig config) {
    current = config;
  }
}
