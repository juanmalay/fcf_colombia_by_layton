import '../../domain/entities/match.dart';
import '../../domain/repositories/match_repository.dart';
import '../datasources/matches_local_datasource.dart';
import '../datasources/matches_remote_datasource.dart';
import '../../../../core/utils/logger.dart';

/// Implementación del repositorio de partidos
/// Orquesta el acceso a datos: intenta remoto, fallback a local si falla
class MatchRepositoryImpl implements MatchRepository {
  final MatchesRemoteDataSource remoteDataSource;
  final MatchesLocalDataSource localDataSource;

  MatchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// Claves para caché local
  static const String _upcomingCacheKey = 'upcoming_matches';
  static const String _recentCacheKey = 'recent_matches';

  @override
  Future<List<Match>> getUpcomingMatches() async {
    try {
      AppLogger.info('MatchRepository.getUpcomingMatches: Intentando obtener del remoto');
      
      // Intenta obtener del remoto
      final remoteMatches = await remoteDataSource.getUpcomingMatches();
      
      // Guarda en caché local como fallback
      await localDataSource.saveMatches(remoteMatches, _upcomingCacheKey);
      
      // Convierte a entidades
      return remoteMatches.map((m) => m.toEntity()).toList();
    } catch (e) {
      AppLogger.warning('Error obteniendo partidos próximos del remoto, usando caché local');
      
      // Fallback a caché local
      try {
        final cachedMatches = await localDataSource.getMatches(_upcomingCacheKey);
        return cachedMatches.map((m) => m.toEntity()).toList();
      } catch (cacheError) {
        AppLogger.error('Error obteniendo del caché local también', cacheError);
        return []; // Retorna lista vacía como último recurso
      }
    }
  }

  @override
  Future<List<Match>> getRecentMatches() async {
    try {
      AppLogger.info('MatchRepository.getRecentMatches: Intentando obtener del remoto');
      
      final remoteMatches = await remoteDataSource.getRecentMatches();
      await localDataSource.saveMatches(remoteMatches, _recentCacheKey);
      
      return remoteMatches.map((m) => m.toEntity()).toList();
    } catch (e) {
      AppLogger.warning('Error obteniendo resultados recientes del remoto, usando caché local');
      
      try {
        final cachedMatches = await localDataSource.getMatches(_recentCacheKey);
        return cachedMatches.map((m) => m.toEntity()).toList();
      } catch (cacheError) {
        AppLogger.error('Error obteniendo del caché local también', cacheError);
        return [];
      }
    }
  }

  @override
  Future<Match?> getMatchDetail(String id) async {
    try {
      AppLogger.info('MatchRepository.getMatchDetail($id): Intentando obtener del remoto');
      
      final remoteMatch = await remoteDataSource.getMatchDetail(id);
      return remoteMatch?.toEntity();
    } catch (e) {
      AppLogger.error('Error obteniendo detalle de partido', e);
      final cachedMatches = [
        ...await localDataSource.getMatches(_upcomingCacheKey),
        ...await localDataSource.getMatches(_recentCacheKey),
      ];

      for (final match in cachedMatches) {
        if (match.id == id) {
          return match.toEntity();
        }
      }

      return null;
    }
  }

  @override
  Future<List<Match>> getMatchesByTournament(String tournament) async {
    try {
      AppLogger.info('MatchRepository.getMatchesByTournament($tournament)');
      
      final remoteMatches = await remoteDataSource.getMatchesByTournament(tournament);
      return remoteMatches.map((m) => m.toEntity()).toList();
    } catch (e) {
      AppLogger.error('Error obteniendo partidos del torneo', e);
      return [];
    }
  }

  @override
  Future<List<Match>> getMatchesByTeam(String teamName) async {
    try {
      AppLogger.info('MatchRepository.getMatchesByTeam($teamName)');
      
      final remoteMatches = await remoteDataSource.getMatchesByTeam(teamName);
      return remoteMatches.map((m) => m.toEntity()).toList();
    } catch (e) {
      AppLogger.error('Error obteniendo partidos del equipo', e);
      return [];
    }
  }
}
