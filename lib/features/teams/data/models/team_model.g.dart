// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamModelImpl _$$TeamModelImplFromJson(Map<String, dynamic> json) =>
    _$TeamModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      country: json['country'] as String,
      logoUrl: json['logoUrl'] as String?,
      stadium: json['stadium'] as String?,
      coach: json['coach'] as String?,
    );

Map<String, dynamic> _$$TeamModelImplToJson(_$TeamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'country': instance.country,
      'logoUrl': instance.logoUrl,
      'stadium': instance.stadium,
      'coach': instance.coach,
    };
