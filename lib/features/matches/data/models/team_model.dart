import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/team.dart' as team_entity;

part 'team_model.freezed.dart';
part 'team_model.g.dart';

/// DTO de Team - representa la estructura JSON del backend
/// 
/// NOTA: En endpoints de matches, los equipos vienen como strings simples,
/// no como objetos. Usar MatchModel.homeTeamName directamente.
@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    @JsonKey(fromJson: _logoUrlFromJson)
    String? logoUrl,
  }) = _TeamModel;

  const TeamModel._();

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  /// Convierte a entidad de dominio
  team_entity.Team toEntity() => team_entity.Team(
        id: id,
        name: name,
        logoUrl: logoUrl ?? '',
      );
}

/// FromJson converter para logoUrl - maneja null y defaults
String? _logoUrlFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return null;
}
