import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/team.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String shortName,
    required String country,
    String? logoUrl,
    String? stadium,
    String? coach,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

extension TeamModelExt on TeamModel {
  /// Convertir a entidad de dominio
  Team toEntity() {
    return Team(
      id: id,
      name: name,
      shortName: shortName,
      country: country,
      logoUrl: logoUrl,
      stadium: stadium,
      coach: coach,
    );
  }

  /// Crear desde entidad de dominio
  static TeamModel fromEntity(Team team) {
    return TeamModel(
      id: team.id,
      name: team.name,
      shortName: team.shortName,
      country: team.country,
      logoUrl: team.logoUrl,
      stadium: team.stadium,
      coach: team.coach,
    );
  }
}
