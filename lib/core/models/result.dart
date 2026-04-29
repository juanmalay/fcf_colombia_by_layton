import 'app_exception.dart';

/// Tipo de resultado genérico: Success(T) o Failure(AppException)
/// Similar a Either en Haskell/Dart
abstract class Result<T> {
  const Result();

  /// Map success value
  Result<U> map<U>(U Function(T) fn) {
    if (this is Success<T>) {
      return Success(fn((this as Success<T>).data));
    }
    return Failure((this as Failure<T>).exception);
  }

  /// Flat map (bind)
  Result<U> flatMap<U>(Result<U> Function(T) fn) {
    if (this is Success<T>) {
      return fn((this as Success<T>).data);
    }
    return Failure((this as Failure<T>).exception);
  }

  /// Pattern matching
  V fold<V>(
    V Function(AppException) onFailure,
    V Function(T) onSuccess,
  ) {
    if (this is Failure<T>) {
      return onFailure((this as Failure<T>).exception);
    }
    return onSuccess((this as Success<T>).data);
  }

  /// Get value or null
  T? getOrNull() {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    return null;
  }

  /// Get exception or null
  AppException? exceptionOrNull() {
    if (this is Failure<T>) {
      return (this as Failure<T>).exception;
    }
    return null;
  }

  /// Check if success
  bool get isSuccess => this is Success<T>;

  /// Check if failure
  bool get isFailure => this is Failure<T>;
}

/// Success result containing data
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  String toString() => 'Success<$T>($data)';
}

/// Failure result containing exception
class Failure<T> extends Result<T> {
  final AppException exception;

  const Failure(this.exception);

  @override
  String toString() => 'Failure<$T>(${exception.message})';
}

/// Extension para simplificar creación de resultados
extension ResultX<T> on T {
  Result<T> toSuccess() => Success(this);
}

extension ExceptionX on AppException {
  Result<T> toFailure<T>() => Failure<T>(this);
}
