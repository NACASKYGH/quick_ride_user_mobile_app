// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusInfoEntity _$BusInfoEntityFromJson(Map<String, dynamic> json) {
  return _BusInfoEntity.fromJson(json);
}

/// @nodoc
mixin _$BusInfoEntity {
  @JsonKey(name: 'TripID')
  String? get tripId => throw _privateConstructorUsedError;
  @JsonKey(name: 'TName')
  String? get tName => throw _privateConstructorUsedError;
  @JsonKey(name: 'FromLocation')
  String? get fromLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'ToLocation')
  String? get toLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'DestFromID')
  String? get fromLocationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'DestToID')
  String? get destinationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'FAR')
  String? get lorryFare => throw _privateConstructorUsedError;
  @JsonKey(name: 'Depart')
  String? get departTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'LSEAT')
  String? get totalSeats => throw _privateConstructorUsedError;
  @JsonKey(name: 'logoURL')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'BusType')
  String? get busType => throw _privateConstructorUsedError;
  @JsonKey(name: 'TerminalName')
  String? get terminalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'BusNo')
  String? get busNo => throw _privateConstructorUsedError;

  /// Serializes this BusInfoEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusInfoEntityCopyWith<BusInfoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusInfoEntityCopyWith<$Res> {
  factory $BusInfoEntityCopyWith(
    BusInfoEntity value,
    $Res Function(BusInfoEntity) then,
  ) = _$BusInfoEntityCopyWithImpl<$Res, BusInfoEntity>;
  @useResult
  $Res call({
    @JsonKey(name: 'TripID') String? tripId,
    @JsonKey(name: 'TName') String? tName,
    @JsonKey(name: 'FromLocation') String? fromLocation,
    @JsonKey(name: 'ToLocation') String? toLocation,
    @JsonKey(name: 'DestFromID') String? fromLocationId,
    @JsonKey(name: 'DestToID') String? destinationId,
    @JsonKey(name: 'FAR') String? lorryFare,
    @JsonKey(name: 'Depart') String? departTime,
    @JsonKey(name: 'LSEAT') String? totalSeats,
    @JsonKey(name: 'logoURL') String? avatar,
    @JsonKey(name: 'BusType') String? busType,
    @JsonKey(name: 'TerminalName') String? terminalName,
    @JsonKey(name: 'BusNo') String? busNo,
  });
}

/// @nodoc
class _$BusInfoEntityCopyWithImpl<$Res, $Val extends BusInfoEntity>
    implements $BusInfoEntityCopyWith<$Res> {
  _$BusInfoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = freezed,
    Object? tName = freezed,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? fromLocationId = freezed,
    Object? destinationId = freezed,
    Object? lorryFare = freezed,
    Object? departTime = freezed,
    Object? totalSeats = freezed,
    Object? avatar = freezed,
    Object? busType = freezed,
    Object? terminalName = freezed,
    Object? busNo = freezed,
  }) {
    return _then(
      _value.copyWith(
            tripId:
                freezed == tripId
                    ? _value.tripId
                    : tripId // ignore: cast_nullable_to_non_nullable
                        as String?,
            tName:
                freezed == tName
                    ? _value.tName
                    : tName // ignore: cast_nullable_to_non_nullable
                        as String?,
            fromLocation:
                freezed == fromLocation
                    ? _value.fromLocation
                    : fromLocation // ignore: cast_nullable_to_non_nullable
                        as String?,
            toLocation:
                freezed == toLocation
                    ? _value.toLocation
                    : toLocation // ignore: cast_nullable_to_non_nullable
                        as String?,
            fromLocationId:
                freezed == fromLocationId
                    ? _value.fromLocationId
                    : fromLocationId // ignore: cast_nullable_to_non_nullable
                        as String?,
            destinationId:
                freezed == destinationId
                    ? _value.destinationId
                    : destinationId // ignore: cast_nullable_to_non_nullable
                        as String?,
            lorryFare:
                freezed == lorryFare
                    ? _value.lorryFare
                    : lorryFare // ignore: cast_nullable_to_non_nullable
                        as String?,
            departTime:
                freezed == departTime
                    ? _value.departTime
                    : departTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            totalSeats:
                freezed == totalSeats
                    ? _value.totalSeats
                    : totalSeats // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as String?,
            busType:
                freezed == busType
                    ? _value.busType
                    : busType // ignore: cast_nullable_to_non_nullable
                        as String?,
            terminalName:
                freezed == terminalName
                    ? _value.terminalName
                    : terminalName // ignore: cast_nullable_to_non_nullable
                        as String?,
            busNo:
                freezed == busNo
                    ? _value.busNo
                    : busNo // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusInfoEntityImplCopyWith<$Res>
    implements $BusInfoEntityCopyWith<$Res> {
  factory _$$BusInfoEntityImplCopyWith(
    _$BusInfoEntityImpl value,
    $Res Function(_$BusInfoEntityImpl) then,
  ) = __$$BusInfoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'TripID') String? tripId,
    @JsonKey(name: 'TName') String? tName,
    @JsonKey(name: 'FromLocation') String? fromLocation,
    @JsonKey(name: 'ToLocation') String? toLocation,
    @JsonKey(name: 'DestFromID') String? fromLocationId,
    @JsonKey(name: 'DestToID') String? destinationId,
    @JsonKey(name: 'FAR') String? lorryFare,
    @JsonKey(name: 'Depart') String? departTime,
    @JsonKey(name: 'LSEAT') String? totalSeats,
    @JsonKey(name: 'logoURL') String? avatar,
    @JsonKey(name: 'BusType') String? busType,
    @JsonKey(name: 'TerminalName') String? terminalName,
    @JsonKey(name: 'BusNo') String? busNo,
  });
}

/// @nodoc
class __$$BusInfoEntityImplCopyWithImpl<$Res>
    extends _$BusInfoEntityCopyWithImpl<$Res, _$BusInfoEntityImpl>
    implements _$$BusInfoEntityImplCopyWith<$Res> {
  __$$BusInfoEntityImplCopyWithImpl(
    _$BusInfoEntityImpl _value,
    $Res Function(_$BusInfoEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = freezed,
    Object? tName = freezed,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? fromLocationId = freezed,
    Object? destinationId = freezed,
    Object? lorryFare = freezed,
    Object? departTime = freezed,
    Object? totalSeats = freezed,
    Object? avatar = freezed,
    Object? busType = freezed,
    Object? terminalName = freezed,
    Object? busNo = freezed,
  }) {
    return _then(
      _$BusInfoEntityImpl(
        tripId:
            freezed == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                    as String?,
        tName:
            freezed == tName
                ? _value.tName
                : tName // ignore: cast_nullable_to_non_nullable
                    as String?,
        fromLocation:
            freezed == fromLocation
                ? _value.fromLocation
                : fromLocation // ignore: cast_nullable_to_non_nullable
                    as String?,
        toLocation:
            freezed == toLocation
                ? _value.toLocation
                : toLocation // ignore: cast_nullable_to_non_nullable
                    as String?,
        fromLocationId:
            freezed == fromLocationId
                ? _value.fromLocationId
                : fromLocationId // ignore: cast_nullable_to_non_nullable
                    as String?,
        destinationId:
            freezed == destinationId
                ? _value.destinationId
                : destinationId // ignore: cast_nullable_to_non_nullable
                    as String?,
        lorryFare:
            freezed == lorryFare
                ? _value.lorryFare
                : lorryFare // ignore: cast_nullable_to_non_nullable
                    as String?,
        departTime:
            freezed == departTime
                ? _value.departTime
                : departTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        totalSeats:
            freezed == totalSeats
                ? _value.totalSeats
                : totalSeats // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as String?,
        busType:
            freezed == busType
                ? _value.busType
                : busType // ignore: cast_nullable_to_non_nullable
                    as String?,
        terminalName:
            freezed == terminalName
                ? _value.terminalName
                : terminalName // ignore: cast_nullable_to_non_nullable
                    as String?,
        busNo:
            freezed == busNo
                ? _value.busNo
                : busNo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusInfoEntityImpl extends _BusInfoEntity {
  const _$BusInfoEntityImpl({
    @JsonKey(name: 'TripID') this.tripId,
    @JsonKey(name: 'TName') this.tName,
    @JsonKey(name: 'FromLocation') this.fromLocation,
    @JsonKey(name: 'ToLocation') this.toLocation,
    @JsonKey(name: 'DestFromID') this.fromLocationId,
    @JsonKey(name: 'DestToID') this.destinationId,
    @JsonKey(name: 'FAR') this.lorryFare,
    @JsonKey(name: 'Depart') this.departTime,
    @JsonKey(name: 'LSEAT') this.totalSeats,
    @JsonKey(name: 'logoURL') this.avatar,
    @JsonKey(name: 'BusType') this.busType,
    @JsonKey(name: 'TerminalName') this.terminalName,
    @JsonKey(name: 'BusNo') this.busNo,
  }) : super._();

  factory _$BusInfoEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusInfoEntityImplFromJson(json);

  @override
  @JsonKey(name: 'TripID')
  final String? tripId;
  @override
  @JsonKey(name: 'TName')
  final String? tName;
  @override
  @JsonKey(name: 'FromLocation')
  final String? fromLocation;
  @override
  @JsonKey(name: 'ToLocation')
  final String? toLocation;
  @override
  @JsonKey(name: 'DestFromID')
  final String? fromLocationId;
  @override
  @JsonKey(name: 'DestToID')
  final String? destinationId;
  @override
  @JsonKey(name: 'FAR')
  final String? lorryFare;
  @override
  @JsonKey(name: 'Depart')
  final String? departTime;
  @override
  @JsonKey(name: 'LSEAT')
  final String? totalSeats;
  @override
  @JsonKey(name: 'logoURL')
  final String? avatar;
  @override
  @JsonKey(name: 'BusType')
  final String? busType;
  @override
  @JsonKey(name: 'TerminalName')
  final String? terminalName;
  @override
  @JsonKey(name: 'BusNo')
  final String? busNo;

  @override
  String toString() {
    return 'BusInfoEntity(tripId: $tripId, tName: $tName, fromLocation: $fromLocation, toLocation: $toLocation, fromLocationId: $fromLocationId, destinationId: $destinationId, lorryFare: $lorryFare, departTime: $departTime, totalSeats: $totalSeats, avatar: $avatar, busType: $busType, terminalName: $terminalName, busNo: $busNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusInfoEntityImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.tName, tName) || other.tName == tName) &&
            (identical(other.fromLocation, fromLocation) ||
                other.fromLocation == fromLocation) &&
            (identical(other.toLocation, toLocation) ||
                other.toLocation == toLocation) &&
            (identical(other.fromLocationId, fromLocationId) ||
                other.fromLocationId == fromLocationId) &&
            (identical(other.destinationId, destinationId) ||
                other.destinationId == destinationId) &&
            (identical(other.lorryFare, lorryFare) ||
                other.lorryFare == lorryFare) &&
            (identical(other.departTime, departTime) ||
                other.departTime == departTime) &&
            (identical(other.totalSeats, totalSeats) ||
                other.totalSeats == totalSeats) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.busType, busType) || other.busType == busType) &&
            (identical(other.terminalName, terminalName) ||
                other.terminalName == terminalName) &&
            (identical(other.busNo, busNo) || other.busNo == busNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tripId,
    tName,
    fromLocation,
    toLocation,
    fromLocationId,
    destinationId,
    lorryFare,
    departTime,
    totalSeats,
    avatar,
    busType,
    terminalName,
    busNo,
  );

  /// Create a copy of BusInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusInfoEntityImplCopyWith<_$BusInfoEntityImpl> get copyWith =>
      __$$BusInfoEntityImplCopyWithImpl<_$BusInfoEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusInfoEntityImplToJson(this);
  }
}

abstract class _BusInfoEntity extends BusInfoEntity {
  const factory _BusInfoEntity({
    @JsonKey(name: 'TripID') final String? tripId,
    @JsonKey(name: 'TName') final String? tName,
    @JsonKey(name: 'FromLocation') final String? fromLocation,
    @JsonKey(name: 'ToLocation') final String? toLocation,
    @JsonKey(name: 'DestFromID') final String? fromLocationId,
    @JsonKey(name: 'DestToID') final String? destinationId,
    @JsonKey(name: 'FAR') final String? lorryFare,
    @JsonKey(name: 'Depart') final String? departTime,
    @JsonKey(name: 'LSEAT') final String? totalSeats,
    @JsonKey(name: 'logoURL') final String? avatar,
    @JsonKey(name: 'BusType') final String? busType,
    @JsonKey(name: 'TerminalName') final String? terminalName,
    @JsonKey(name: 'BusNo') final String? busNo,
  }) = _$BusInfoEntityImpl;
  const _BusInfoEntity._() : super._();

  factory _BusInfoEntity.fromJson(Map<String, dynamic> json) =
      _$BusInfoEntityImpl.fromJson;

  @override
  @JsonKey(name: 'TripID')
  String? get tripId;
  @override
  @JsonKey(name: 'TName')
  String? get tName;
  @override
  @JsonKey(name: 'FromLocation')
  String? get fromLocation;
  @override
  @JsonKey(name: 'ToLocation')
  String? get toLocation;
  @override
  @JsonKey(name: 'DestFromID')
  String? get fromLocationId;
  @override
  @JsonKey(name: 'DestToID')
  String? get destinationId;
  @override
  @JsonKey(name: 'FAR')
  String? get lorryFare;
  @override
  @JsonKey(name: 'Depart')
  String? get departTime;
  @override
  @JsonKey(name: 'LSEAT')
  String? get totalSeats;
  @override
  @JsonKey(name: 'logoURL')
  String? get avatar;
  @override
  @JsonKey(name: 'BusType')
  String? get busType;
  @override
  @JsonKey(name: 'TerminalName')
  String? get terminalName;
  @override
  @JsonKey(name: 'BusNo')
  String? get busNo;

  /// Create a copy of BusInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusInfoEntityImplCopyWith<_$BusInfoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
