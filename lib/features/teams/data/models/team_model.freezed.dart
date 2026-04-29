// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get shortName => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get stadium => throw _privateConstructorUsedError;
  String? get coach => throw _privateConstructorUsedError;

  /// Serializes this TeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String shortName,
      String country,
      String? logoUrl,
      String? stadium,
      String? coach});
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = null,
    Object? country = null,
    Object? logoUrl = freezed,
    Object? stadium = freezed,
    Object? coach = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stadium: freezed == stadium
          ? _value.stadium
          : stadium // ignore: cast_nullable_to_non_nullable
              as String?,
      coach: freezed == coach
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
          _$TeamModelImpl value, $Res Function(_$TeamModelImpl) then) =
      __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String shortName,
      String country,
      String? logoUrl,
      String? stadium,
      String? coach});
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
      _$TeamModelImpl _value, $Res Function(_$TeamModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? shortName = null,
    Object? country = null,
    Object? logoUrl = freezed,
    Object? stadium = freezed,
    Object? coach = freezed,
  }) {
    return _then(_$TeamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stadium: freezed == stadium
          ? _value.stadium
          : stadium // ignore: cast_nullable_to_non_nullable
              as String?,
      coach: freezed == coach
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl(
      {required this.id,
      required this.name,
      required this.shortName,
      required this.country,
      this.logoUrl,
      this.stadium,
      this.coach});

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String shortName;
  @override
  final String country;
  @override
  final String? logoUrl;
  @override
  final String? stadium;
  @override
  final String? coach;

  @override
  String toString() {
    return 'TeamModel(id: $id, name: $name, shortName: $shortName, country: $country, logoUrl: $logoUrl, stadium: $stadium, coach: $coach)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.stadium, stadium) || other.stadium == stadium) &&
            (identical(other.coach, coach) || other.coach == coach));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, shortName, country, logoUrl, stadium, coach);

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      __$$TeamModelImplCopyWithImpl<_$TeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamModelImplToJson(
      this,
    );
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel(
      {required final String id,
      required final String name,
      required final String shortName,
      required final String country,
      final String? logoUrl,
      final String? stadium,
      final String? coach}) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get shortName;
  @override
  String get country;
  @override
  String? get logoUrl;
  @override
  String? get stadium;
  @override
  String? get coach;

  /// Create a copy of TeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
