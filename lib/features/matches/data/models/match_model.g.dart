// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      id: json['id'] as String,
      homeTeamName: json['homeTeam'] as String,
      awayTeamName: json['awayTeam'] as String,
      homeScore: (json['homeScore'] as num?)?.toInt(),
      awayScore: (json['awayScore'] as num?)?.toInt(),
      matchDate: json['matchDate'] as String,
      tournament: json['tournament'] as String,
      status: json['status'] as String,
      venue: json['venue'] as String,
      referee: json['referee'] as String,
      createdAt: _createdAtFromJson(json['createdAt']),
      updatedAt: _updatedAtFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'homeTeam': instance.homeTeamName,
      'awayTeam': instance.awayTeamName,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'matchDate': instance.matchDate,
      'tournament': instance.tournament,
      'status': instance.status,
      'venue': instance.venue,
      'referee': instance.referee,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
