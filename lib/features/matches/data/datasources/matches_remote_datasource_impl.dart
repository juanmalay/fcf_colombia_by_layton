import '../models/match_model.dart';
import 'matches_remote_datasource.dart';
import '../../../../core/services/dio_service.dart';
import '../../../../core/network/endpoints.dart';
import '../../../../core/utils/logger.dart';

/// Implementación de MatchesRemoteDataSource
/// Consume la API REST del backend usando DioService
class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final DioService dio;

  const MatchesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    try {
      AppLogger.info('Fetching upcoming matches from ${ApiEndpoints.upcomingMatches}');
      final response = await dio.get<List<dynamic>>(ApiEndpoints.upcomingMatches);
      
      if (response.data == null) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      AppLogger.error('Error fetching upcoming matches', e);
      rethrow;
    }
  }

  @override
  Future<List<MatchModel>> getRecentMatches() async {
    try {
      AppLogger.info('Fetching recent matches from ${ApiEndpoints.recentMatches}');
      final response = await dio.get<List<dynamic>>(ApiEndpoints.recentMatches);
      
      if (response.data == null) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      AppLogger.error('Error fetching recent matches', e);
      rethrow;
    }
  }

  @override
  Future<MatchModel?> getMatchDetail(String id) async {
    try {
      final endpoint = ApiEndpoints.getMatchDetail(id);
      AppLogger.info('Fetching match detail: $endpoint');
      final response = await dio.get<Map<String, dynamic>>(endpoint);
      
      if (response.data == null) {
        return null;
      }

      return MatchModel.fromJson(response.data!);
    } catch (e) {
      AppLogger.error('Error fetching match detail', e);
      return null;
    }
  }

  @override
  Future<List<MatchModel>> getMatchesByTournament(String tournament) async {
    try {
      final endpoint = ApiEndpoints.getMatchesByTournament(tournament);
      AppLogger.info('Fetching matches for tournament: $endpoint');
      final response = await dio.get<List<dynamic>>(endpoint);
      
      if (response.data == null) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      AppLogger.error('Error fetching tournament matches', e);
      rethrow;
    }
  }

  @override
  Future<List<MatchModel>> getMatchesByTeam(String teamName) async {
    try {
      final endpoint = ApiEndpoints.getMatchesByTeam(teamName);
      AppLogger.info('Fetching matches for team: $endpoint');
      final response = await dio.get<List<dynamic>>(endpoint);
      
      if (response.data == null) {
        return [];
      }

      return (response.data as List<dynamic>)
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      AppLogger.error('Error fetching team matches', e);
      rethrow;
    }
  }
}
