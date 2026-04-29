import '../models/match_model.dart';
import 'matches_local_datasource.dart';
import '../../../../core/utils/logger.dart';

/// Implementación de MatchesLocalDataSource
/// Actualmente usa caché en memoria. Puede expandirse con SharedPreferences o SQLite
class MatchesLocalDataSourceImpl implements MatchesLocalDataSource {
  /// Almacén en memoria (temporal, se limpia entre sesiones)
  final Map<String, List<MatchModel>> _cache = {};

  @override
  Future<void> saveMatches(List<MatchModel> matches, String key) async {
    try {
      AppLogger.info('Saving ${matches.length} matches to local cache with key: $key');
      _cache[key] = matches;
    } catch (e) {
      AppLogger.error('Error saving matches to local cache', e);
      rethrow;
    }
  }

  @override
  Future<List<MatchModel>> getMatches(String key) async {
    try {
      final matches = _cache[key] ?? [];
      AppLogger.info('Retrieved ${matches.length} matches from local cache (key: $key)');
      return matches;
    } catch (e) {
      AppLogger.error('Error retrieving matches from local cache', e);
      return [];
    }
  }

  @override
  Future<void> clearCache(String key) async {
    try {
      AppLogger.info('Clearing local cache with key: $key');
      _cache.remove(key);
    } catch (e) {
      AppLogger.error('Error clearing local cache', e);
      rethrow;
    }
  }

  @override
  Future<bool> hasMatches(String key) async {
    try {
      final has = _cache.containsKey(key) && (_cache[key]?.isNotEmpty ?? false);
      AppLogger.info('Checking cache (key: $key): $has');
      return has;
    } catch (e) {
      AppLogger.error('Error checking local cache', e);
      return false;
    }
  }
}
