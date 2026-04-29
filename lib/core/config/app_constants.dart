/// Constantes globales de la aplicación
class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.fcf-app.com';
  static const String apiVersion = '/v1';
  static const Duration apiTimeout = Duration(seconds: 10);

  // Asset Paths
  static const String mockDataPath = 'assets/data/';

  // Layout
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  static const double avatarRadius = 32.0;

  // App Metadata
  static const String appName = 'FCF Colombia';
  static const String appVersion = '1.0.0';
}
