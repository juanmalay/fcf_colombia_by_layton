import '../models/match_model.dart';

/// Contrato de fuente de datos local (caché, BD local)
abstract class MatchesLocalDataSource {
  /// Guarda partidos en caché local
  Future<void> saveMatches(List<MatchModel> matches, String key);

  /// Obtiene partidos del caché local
  Future<List<MatchModel>> getMatches(String key);

  /// Limpia el caché
  Future<void> clearCache(String key);

  /// Verifica si hay datos en caché
  Future<bool> hasMatches(String key);
}
