import '../models/team_model.dart';

/// Contrato de fuente de datos local para equipos
abstract class TeamsLocalDataSource {
  /// Guarda equipos en caché local
  Future<void> saveTeams(List<TeamModel> teams);

  /// Obtiene equipos del caché local o semilla de assets
  Future<List<TeamModel>> getTeams();

  /// Busca un equipo por ID en caché local
  Future<TeamModel?> getTeamById(String id);

  /// Busca un equipo por nombre en caché local
  Future<TeamModel?> getTeamByName(String name);
}
