/// Excepciones de la aplicación
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

/// Excepción de red (conexión, timeout, etc)
class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'NETWORK_ERROR',
    stackTrace: stackTrace,
  );
}

/// Excepción del servidor (errores HTTP)
class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required String message,
    this.statusCode,
    String? code,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'SERVER_ERROR',
    stackTrace: stackTrace,
  );
}

/// Excepción de parseo (JSON, etc)
class ParseException extends AppException {
  ParseException({
    required String message,
    String? code,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'PARSE_ERROR',
    stackTrace: stackTrace,
  );
}

/// Excepción desconocida
class UnknownException extends AppException {
  UnknownException({
    required String message,
    String? code,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'UNKNOWN_ERROR',
    stackTrace: stackTrace,
  );
}

/// Excepción de validación
class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'VALIDATION_ERROR',
    stackTrace: stackTrace,
  );
}
