import '../../domain/entities/team.dart';

/// Contrato para fuente de datos remota de equipos
abstract class TeamsRemoteDataSource {
  /// Obtener todos los equipos del backend
  Future<List<Team>> getAllTeams();

  /// Obtener detalles de un equipo
  Future<Team?> getTeamDetail(String id);

  /// Obtener equipo por nombre
  Future<Team?> getTeamByName(String name);
}
