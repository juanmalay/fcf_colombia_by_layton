import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Extensiones útiles para Riverpod WidgetRef
extension WidgetRefX on WidgetRef {
  /// Verificar si un provider está en estado de carga
  bool isLoading<T>(ProviderBase<AsyncValue<T>> provider) {
    return watch(provider).isLoading;
  }

  /// Obtener el error de un provider
  Object? getError<T>(ProviderBase<AsyncValue<T>> provider) {
    return watch(provider).error;
  }

  /// Verificar si hay error
  bool hasError<T>(ProviderBase<AsyncValue<T>> provider) {
    return watch(provider).hasError;
  }

  /// Ejecutar una función cuando el provider cambie y es success
  void onData<T>(
    ProviderBase<AsyncValue<T>> provider,
    void Function(T) onData,
  ) {
    watch(provider).whenData(onData);
  }
}
