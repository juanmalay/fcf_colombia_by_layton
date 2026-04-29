import '../entities/team.dart';

/// Contrato de repositorio para equipos
abstract class TeamRepository {
  /// Obtener todos los equipos
  Future<List<Team>> getAllTeams();

  /// Obtener detalles de un equipo por ID
  Future<Team?> getTeamDetail(String id);

  /// Obtener equipo por nombre
  Future<Team?> getTeamByName(String name);
}
