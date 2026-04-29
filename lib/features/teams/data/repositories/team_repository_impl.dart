import '../../domain/entities/team.dart';
import '../../domain/repositories/team_repository.dart';
import '../datasources/teams_remote_datasource.dart';

/// Implementación de TeamRepository
class TeamRepositoryImpl implements TeamRepository {
  final TeamsRemoteDataSource remoteDataSource;

  // Cache en memoria
  final Map<String, Team> _teamCache = {};
  List<Team>? _allTeamsCache;

  TeamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      // Retornar cache si disponible
      if (_allTeamsCache != null) {
        return _allTeamsCache!;
      }

      final teams = await remoteDataSource.getAllTeams();
      
      // Guardar en cache
      _allTeamsCache = teams;
      for (var team in teams) {
        _teamCache[team.id] = team;
      }

      return teams;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Team?> getTeamDetail(String id) async {
    try {
      // Verificar cache primero
      if (_teamCache.containsKey(id)) {
        return _teamCache[id];
      }

      final team = await remoteDataSource.getTeamDetail(id);
      
      if (team != null) {
        _teamCache[id] = team;
      }

      return team;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Team?> getTeamByName(String name) async {
    try {
      final team = await remoteDataSource.getTeamByName(name);
      
      if (team != null) {
        _teamCache[team.id] = team;
      }

      return team;
    } catch (e) {
      rethrow;
    }
  }
}
