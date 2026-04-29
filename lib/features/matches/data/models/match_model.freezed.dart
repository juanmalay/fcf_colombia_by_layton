// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) {
  return _MatchModel.fromJson(json);
}

/// @nodoc
mixin _$MatchModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'homeTeam')
  String get homeTeamName => throw _privateConstructorUsedError;
  @JsonKey(name: 'awayTeam')
  String get awayTeamName => throw _privateConstructorUsedError;
  @JsonKey(name: 'homeScore')
  int? get homeScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'awayScore')
  int? get awayScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchDate')
  String get matchDate => throw _privateConstructorUsedError;
  String get tournament => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get venue => throw _privateConstructorUsedError;
  String get referee =>
      throw _privateConstructorUsedError; // Estos campos NO vienen en /matches/upcoming ni /matches/recent
// Se definen como nullable y con defaults
  @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MatchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchModelCopyWith<MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) then) =
      _$MatchModelCopyWithImpl<$Res, MatchModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'homeTeam') String homeTeamName,
      @JsonKey(name: 'awayTeam') String awayTeamName,
      @JsonKey(name: 'homeScore') int? homeScore,
      @JsonKey(name: 'awayScore') int? awayScore,
      @JsonKey(name: 'matchDate') String matchDate,
      String tournament,
      String status,
      String venue,
      String referee,
      @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
      String? createdAt,
      @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
      String? updatedAt});
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? matchDate = null,
    Object? tournament = null,
    Object? status = null,
    Object? venue = null,
    Object? referee = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeScore: freezed == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayScore: freezed == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String,
      tournament: null == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      referee: null == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchModelImplCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$$MatchModelImplCopyWith(
          _$MatchModelImpl value, $Res Function(_$MatchModelImpl) then) =
      __$$MatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'homeTeam') String homeTeamName,
      @JsonKey(name: 'awayTeam') String awayTeamName,
      @JsonKey(name: 'homeScore') int? homeScore,
      @JsonKey(name: 'awayScore') int? awayScore,
      @JsonKey(name: 'matchDate') String matchDate,
      String tournament,
      String status,
      String venue,
      String referee,
      @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
      String? createdAt,
      @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
      String? updatedAt});
}

/// @nodoc
class __$$MatchModelImplCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$MatchModelImpl>
    implements _$$MatchModelImplCopyWith<$Res> {
  __$$MatchModelImplCopyWithImpl(
      _$MatchModelImpl _value, $Res Function(_$MatchModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? matchDate = null,
    Object? tournament = null,
    Object? status = null,
    Object? venue = null,
    Object? referee = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeScore: freezed == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayScore: freezed == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String,
      tournament: null == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      referee: null == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchModelImpl extends _MatchModel {
  const _$MatchModelImpl(
      {required this.id,
      @JsonKey(name: 'homeTeam') required this.homeTeamName,
      @JsonKey(name: 'awayTeam') required this.awayTeamName,
      @JsonKey(name: 'homeScore') this.homeScore,
      @JsonKey(name: 'awayScore') this.awayScore,
      @JsonKey(name: 'matchDate') required this.matchDate,
      required this.tournament,
      required this.status,
      required this.venue,
      required this.referee,
      @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson) this.createdAt,
      @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson) this.updatedAt})
      : super._();

  factory _$MatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'homeTeam')
  final String homeTeamName;
  @override
  @JsonKey(name: 'awayTeam')
  final String awayTeamName;
  @override
  @JsonKey(name: 'homeScore')
  final int? homeScore;
  @override
  @JsonKey(name: 'awayScore')
  final int? awayScore;
  @override
  @JsonKey(name: 'matchDate')
  final String matchDate;
  @override
  final String tournament;
  @override
  final String status;
  @override
  final String venue;
  @override
  final String referee;
// Estos campos NO vienen en /matches/upcoming ni /matches/recent
// Se definen como nullable y con defaults
  @override
  @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
  final String? createdAt;
  @override
  @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
  final String? updatedAt;

  @override
  String toString() {
    return 'MatchModel(id: $id, homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, homeScore: $homeScore, awayScore: $awayScore, matchDate: $matchDate, tournament: $tournament, status: $status, venue: $venue, referee: $referee, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.homeScore, homeScore) ||
                other.homeScore == homeScore) &&
            (identical(other.awayScore, awayScore) ||
                other.awayScore == awayScore) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.referee, referee) || other.referee == referee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      homeTeamName,
      awayTeamName,
      homeScore,
      awayScore,
      matchDate,
      tournament,
      status,
      venue,
      referee,
      createdAt,
      updatedAt);

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      __$$MatchModelImplCopyWithImpl<_$MatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchModelImplToJson(
      this,
    );
  }
}

abstract class _MatchModel extends MatchModel {
  const factory _MatchModel(
      {required final String id,
      @JsonKey(name: 'homeTeam') required final String homeTeamName,
      @JsonKey(name: 'awayTeam') required final String awayTeamName,
      @JsonKey(name: 'homeScore') final int? homeScore,
      @JsonKey(name: 'awayScore') final int? awayScore,
      @JsonKey(name: 'matchDate') required final String matchDate,
      required final String tournament,
      required final String status,
      required final String venue,
      required final String referee,
      @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
      final String? createdAt,
      @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
      final String? updatedAt}) = _$MatchModelImpl;
  const _MatchModel._() : super._();

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$MatchModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'homeTeam')
  String get homeTeamName;
  @override
  @JsonKey(name: 'awayTeam')
  String get awayTeamName;
  @override
  @JsonKey(name: 'homeScore')
  int? get homeScore;
  @override
  @JsonKey(name: 'awayScore')
  int? get awayScore;
  @override
  @JsonKey(name: 'matchDate')
  String get matchDate;
  @override
  String get tournament;
  @override
  String get status;
  @override
  String get venue;
  @override
  String
      get referee; // Estos campos NO vienen en /matches/upcoming ni /matches/recent
// Se definen como nullable y con defaults
  @override
  @JsonKey(name: 'createdAt', fromJson: _createdAtFromJson)
  String? get createdAt;
  @override
  @JsonKey(name: 'updatedAt', fromJson: _updatedAtFromJson)
  String? get updatedAt;

  /// Create a copy of MatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
