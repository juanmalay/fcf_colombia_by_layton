import 'package:dio/dio.dart';
import '../config/app_constants.dart';
import '../config/environment.dart';
import '../models/app_exception.dart';
import '../utils/logger.dart';

/// Servicio HTTP centralizado usando Dio
/// Usa configuración del entorno para adaptar base URL según plataforma
class DioService {
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    final config = EnvironmentConfig.current;
    
    _dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) {
          // Aceptar todos los status codes para manejo personalizado
          return status != null && status < 500;
        },
      ),
    );

    // Interceptadores
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (config.enableLogging) {
            AppLogger.network('→ ${options.method} ${options.path}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (config.enableLogging) {
            AppLogger.network('← ${response.statusCode} ${response.requestOptions.path}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          AppLogger.error('✗ ${error.requestOptions.path}', error);
          return handler.next(error);
        },
      ),
    );
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      _checkResponse(response);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      _checkResponse(response);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      _checkResponse(response);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      _checkResponse(response);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Verificar respuesta HTTP
  void _checkResponse(Response response) {
    if (response.statusCode == null || response.statusCode! >= 400) {
      throw ServerException(
        message: response.statusMessage ?? 'Unknown error',
        statusCode: response.statusCode,
      );
    }
  }

  /// Manejo centralizado de errores
  AppException _handleError(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException(message: 'Connection timeout');

        case DioExceptionType.badResponse:
          final status = error.response?.statusCode;
          return ServerException(
            message: error.response?.statusMessage ?? 'Server error',
            statusCode: status,
          );

        case DioExceptionType.unknown:
          return NetworkException(message: 'Network error');

        default:
          return NetworkException(message: 'Unknown error');
      }
    }

    if (error is AppException) return error;

    return UnknownException(message: error.toString());
  }
}
