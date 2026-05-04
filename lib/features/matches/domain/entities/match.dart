import 'team.dart';

/// Status posible de un partido
enum MatchStatus {
  upcoming,
  inProgress,
  finished,
  postponed;

  /// Convierte string del backend al enum
  static MatchStatus fromString(String status) {
    return MatchStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == status.toUpperCase(),
      orElse: () => MatchStatus.upcoming,
    );
  }

  /// Retorna nombre legible
  String toDisplayString() {
    return switch (this) {
      MatchStatus.upcoming => 'Próximo',
      MatchStatus.inProgress => 'En vivo',
      MatchStatus.finished => 'Finalizado',
      MatchStatus.postponed => 'Aplazado',
    };
  }
}

/// Entidad de partido (modelo de dominio)
class Match {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  final int? homeScore;
  final int? awayScore;
  final DateTime matchDate;
  final String tournament;
  final MatchStatus status;
  final String venue;
  final String referee;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Statistic>? statistics;
  final List<Event>? events;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore,
    this.awayScore,
    required this.matchDate,
    required this.tournament,
    required this.status,
    required this.venue,
    required this.referee,
    required this.createdAt,
    required this.updatedAt,
    this.statistics,
    this.events,
  });

  /// Score como string (ej: "2-1")
  String get scoreDisplay {
    if (homeScore == null || awayScore == null) {
      return '-';
    }
    return '$homeScore-$awayScore';
  }

  /// Título del partido
  String get title => '${homeTeam.name} vs ${awayTeam.name}';

  /// Indica si el partido es futuro
  bool get isUpcoming => DateTime.now().isBefore(matchDate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Match &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Match(id: $id, title: $title, status: $status, score: $scoreDisplay)';

  /// CopyWith para crear nuevas instancias
  Match copyWith({
    String? id,
    Team? homeTeam,
    Team? awayTeam,
    int? homeScore,
    int? awayScore,
    DateTime? matchDate,
    String? tournament,
    MatchStatus? status,
    String? venue,
    String? referee,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Statistic>? statistics,
    List<Event>? events,
  }) {
    return Match(
      id: id ?? this.id,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      matchDate: matchDate ?? this.matchDate,
      tournament: tournament ?? this.tournament,
      status: status ?? this.status,
      venue: venue ?? this.venue,
      referee: referee ?? this.referee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      statistics: statistics ?? this.statistics,
      events: events ?? this.events,
    );
  }
}

class Statistic {
  final String name;
  final dynamic value;

  Statistic({required this.name, required this.value});
}

class Event {
  final String description;
  final String time;

  Event({required this.description, required this.time});
}
