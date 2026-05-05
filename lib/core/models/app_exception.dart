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
    required super.message,
    String? code,
    super.stackTrace,
  }) : super(
    code: code ?? 'NETWORK_ERROR',
  );
}

/// Excepción del servidor (errores HTTP)
class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required super.message,
    this.statusCode,
    String? code,
    super.stackTrace,
  }) : super(
    code: code ?? 'SERVER_ERROR',
  );
}

/// Excepción de parseo (JSON, etc)
class ParseException extends AppException {
  ParseException({
    required super.message,
    String? code,
    super.stackTrace,
  }) : super(
    code: code ?? 'PARSE_ERROR',
  );
}

/// Excepción desconocida
class UnknownException extends AppException {
  UnknownException({
    required super.message,
    String? code,
    super.stackTrace,
  }) : super(
    code: code ?? 'UNKNOWN_ERROR',
  );
}

/// Excepción de validación
class ValidationException extends AppException {
  ValidationException({
    required super.message,
    String? code,
    super.stackTrace,
  }) : super(
    code: code ?? 'VALIDATION_ERROR',
  );
}
