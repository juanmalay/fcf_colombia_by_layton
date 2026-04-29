import '../models/match_model.dart';

/// Contrato de fuente de datos remota (API)
abstract class MatchesRemoteDataSource {
  /// Obtiene lista de partidos próximos del backend
  Future<List<MatchModel>> getUpcomingMatches();

  /// Obtiene lista de partidos finalizados recientemente del backend
  Future<List<MatchModel>> getRecentMatches();

  /// Obtiene detalle de un partido específico
  Future<MatchModel?> getMatchDetail(String id);

  /// Obtiene partidos filtrados por torneo
  Future<List<MatchModel>> getMatchesByTournament(String tournament);

  /// Obtiene partidos filtrados por equipo
  Future<List<MatchModel>> getMatchesByTeam(String teamName);
}
