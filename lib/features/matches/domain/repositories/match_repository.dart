import '../entities/match.dart';

/// Contrato del repositorio de partidos
/// Abstrae dónde se obtienen los datos (API, caché, BD local)
abstract class MatchRepository {
  /// Obtiene lista de partidos próximos
  Future<List<Match>> getUpcomingMatches();

  /// Obtiene lista de partidos finalizados recientemente
  Future<List<Match>> getRecentMatches();

  /// Obtiene detalles de un partido específico por ID
  Future<Match?> getMatchDetail(String id);

  /// Obtiene partidos filtrados por torneo
  Future<List<Match>> getMatchesByTournament(String tournament);

  /// Obtiene partidos filtrados por equipo
  Future<List<Match>> getMatchesByTeam(String teamName);
}
