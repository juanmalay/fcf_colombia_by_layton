import '../../domain/entities/team.dart';
import '../../domain/repositories/team_repository.dart';
import '../datasources/teams_local_datasource.dart';
import '../datasources/teams_remote_datasource.dart';
import '../models/team_model.dart';

/// Implementación de TeamRepository
class TeamRepositoryImpl implements TeamRepository {
  final TeamsRemoteDataSource remoteDataSource;
  final TeamsLocalDataSource localDataSource;

  // Cache en memoria
  final Map<String, Team> _teamCache = {};
  List<Team>? _allTeamsCache;

  TeamRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      // Retornar cache si disponible
      if (_allTeamsCache != null) {
        return _allTeamsCache!;
      }

      final teams = await remoteDataSource.getAllTeams();

      // Guarda en local para fallback
      await localDataSource.saveTeams(
        teams.map((team) => TeamModelExt.fromEntity(team)).toList(),
      );
      
      // Guardar en cache
      _allTeamsCache = teams;
      for (var team in teams) {
        _teamCache[team.id] = team;
      }

      return teams;
    } catch (e) {
      final localTeams = (await localDataSource.getTeams())
          .map((model) => model.toEntity())
          .toList();
      _allTeamsCache = localTeams;
      for (final team in localTeams) {
        _teamCache[team.id] = team;
      }
      return localTeams;
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
      final localTeam = await localDataSource.getTeamById(id);
      if (localTeam != null) {
        final team = localTeam.toEntity();
        _teamCache[id] = team;
        return team;
      }
      return null;
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
      final localTeam = await localDataSource.getTeamByName(name);
      if (localTeam != null) {
        final team = localTeam.toEntity();
        _teamCache[team.id] = team;
        return team;
      }
      return null;
    }
  }
}
