import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../../domain/entities/team.dart' as team_entity;
import 'team_model.dart';

part 'match_model.freezed.dart';
part 'match_model.g.dart';

/// DTO de Match - mapea la respuesta JSON del backend
///
/// Campo nullable:
/// - homeScore: puede ser null para partidos no jugados
/// - awayScore: puede ser null para partidos no jugados
/// - createdAt: NO viene del backend en endpoints /upcoming y /recent
/// - updatedAt: NO viene del backend en endpoints /upcoming y /recent
@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    @JsonKey(name: 'homeTeam') required String homeTeamName,
    @JsonKey(name: 'awayTeam') required String awayTeamName,
    @JsonKey(name: 'homeScore') int? homeScore,
    @JsonKey(name: 'awayScore') int? awayScore,
    @JsonKey(name: 'matchDate') required String matchDate,
    required String tournament,
    required String status,
    required String venue,
    required String referee,
    // Estos campos NO vienen en /matches/upcoming ni /matches/recent
    // Se definen como nullable y con defaults
    @JsonKey(
      name: 'createdAt',
      fromJson: _createdAtFromJson,
    )
    String? createdAt,
    @JsonKey(
      name: 'updatedAt',
      fromJson: _updatedAtFromJson,
    )
    String? updatedAt,
  }) = _MatchModel;

  const MatchModel._();

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  /// Convierte a entidad de dominio
  match_entity.Match toEntity() => match_entity.Match(
        id: id,
        homeTeam: team_entity.Team(id: '', name: homeTeamName, logoUrl: ''),
        awayTeam: team_entity.Team(id: '', name: awayTeamName, logoUrl: ''),
        homeScore: homeScore,
        awayScore: awayScore,
        matchDate: _dateTimeFromString(matchDate),
        tournament: tournament,
        status: match_entity.MatchStatus.fromString(status),
        venue: venue,
        referee: referee,
        // Usar valores por defecto si no vienen del backend
        createdAt: createdAt != null
            ? _dateTimeFromString(createdAt!)
            : DateTime.now(),
        updatedAt: updatedAt != null
            ? _dateTimeFromString(updatedAt!)
            : DateTime.now(),
      );
}

/// Conversor de DateTime desde string ISO 8601
DateTime _dateTimeFromString(String value) {
  return DateTime.parse(value);
}

/// Conversor de DateTime a string ISO 8601
String _dateTimeToString(DateTime value) {
  return value.toIso8601String();
}

/// FromJson converter para createdAt - maneja null del backend
String? _createdAtFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return null;
}

/// FromJson converter para updatedAt - maneja null del backend
String? _updatedAtFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return null;
}
