import '../../domain/entities/team.dart';
import '../../domain/repositories/team_repository.dart';
import '../datasources/teams_remote_datasource.dart';

/// Implementación de TeamRepository
class TeamRepositoryImpl implements TeamRepository {
  final TeamsRemoteDataSource remoteDataSource;

  // Cache en memoria
  final Map<String, Team> _teamCache = {};
  List<Team>? _allTeamsCache;

  static final List<Team> _seedTeams = [
    Team(
      id: 'colombia',
      name: 'Colombia',
      shortName: 'COL',
      country: 'Colombia',
      stadium: 'Estadio Metropolitano Roberto Melendez',
      coach: 'Por confirmar',
    ),
    Team(
      id: 'argentina',
      name: 'Argentina',
      shortName: 'ARG',
      country: 'Argentina',
      stadium: 'Estadio Monumental',
      coach: 'Por confirmar',
    ),
    Team(
      id: 'peru',
      name: 'Peru',
      shortName: 'PER',
      country: 'Peru',
      stadium: 'Estadio Nacional',
      coach: 'Por confirmar',
    ),
  ];

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
      _allTeamsCache = _seedTeams;
      for (final team in _seedTeams) {
        _teamCache[team.id] = team;
      }
      return _seedTeams;
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
      if (_allTeamsCache == null) {
        await getAllTeams();
      }
      return _teamCache[id];
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
      if (_allTeamsCache == null) {
        await getAllTeams();
      }
      final normalized = name.toLowerCase();
      for (final team in _allTeamsCache ?? <Team>[]) {
        if (team.name.toLowerCase() == normalized) {
          return team;
        }
      }
      return null;
    }
  }
}
