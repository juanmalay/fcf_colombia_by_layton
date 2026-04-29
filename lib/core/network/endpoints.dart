/// Definición centralizada de endpoints de la API
/// Usar estas constantes en lugar de strings hardcodeados en las datasources
class ApiEndpoints {
  // Versión de API
  static const String apiVersion = '/api/v1';

  // ==================== MATCHES ====================
  static const String matches = '$apiVersion/matches';
  static const String upcomingMatches = '$matches/upcoming';
  static const String recentMatches = '$matches/recent';
  static const String matchDetail = '$matches/:id';
  static const String matchesByTournament = '$matches/tournament/:tournament';
  static const String matchesByTeam = '$matches/team/:team';

  // ==================== TEAMS ====================
  static const String allTeams = '$apiVersion/teams';
  static const String teams = '$apiVersion/teams';
  static const String teamDetail = '$teams/:id';
  static const String teamByName = '$teams/name/:name';

  // ==================== PLAYERS (para futuro) ====================
  static const String players = '$apiVersion/players';
  static const String playerDetail = '$players/:id';
  static const String playersByTeam = '$players/team/:teamId';

  // ==================== TOURNAMENTS (para futuro) ====================
  static const String tournaments = '$apiVersion/tournaments';
  static const String tournamentDetail = '$tournaments/:id';
  static const String worldCup = '$tournaments/worldcup';

  // ==================== AUTH (para futuro) ====================
  static const String login = '$apiVersion/auth/login';
  static const String logout = '$apiVersion/auth/logout';
  static const String refresh = '$apiVersion/auth/refresh';

  /// Método para construir endpoints dinámicos
  /// Ej: buildEndpoint(matchDetail, {'id': '123'})
  static String buildEndpoint(String template, Map<String, String> params) {
    String endpoint = template;
    params.forEach((key, value) {
      endpoint = endpoint.replaceAll(':$key', value);
    });
    return endpoint;
  }

  /// Obtener detail de un partido
  static String getMatchDetail(String matchId) =>
      buildEndpoint(matchDetail, {'id': matchId});

  /// Obtener partidos de un torneo
  static String getMatchesByTournament(String tournament) =>
      buildEndpoint(matchesByTournament, {'tournament': tournament});

  /// Obtener partidos de un equipo
  static String getMatchesByTeam(String teamName) =>
      buildEndpoint(matchesByTeam, {'team': teamName});

  /// Obtener detalles de un equipo
  static String getTeamDetail(String teamId) =>
      buildEndpoint(teamDetail, {'id': teamId});

  /// Obtener equipo por nombre
  static String getTeamByName(String name) =>
      buildEndpoint(teamByName, {'name': name});
}
