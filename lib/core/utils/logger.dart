import '../config/environment.dart';

/// Logger simple para la aplicación
class AppLogger {
  static const String _tag = '[FCF_App]';

  /// Log de información
  static void info(String message) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag ℹ️  $message');
    }
  }

  /// Log de debugging
  static void debug(String message) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag 🐛 $message');
    }
  }

  /// Log de advertencias
  static void warning(String message) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag ⚠️  $message');
    }
  }

  /// Log de errores
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag ❌ $message');
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }

  /// Log de sucessos
  static void success(String message) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag ✅ $message');
    }
  }

  /// Log de red (API calls)
  static void network(String message) {
    if (EnvironmentConfig.current.enableLogging) {
      print('$_tag 🌐 $message');
    }
  }
}
