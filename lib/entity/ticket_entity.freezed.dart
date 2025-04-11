// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TicketEntity _$TicketEntityFromJson(Map<String, dynamic> json) {
  return _TicketEntity.fromJson(json);
}

/// @nodoc
mixin _$TicketEntity {
  @JsonKey(name: 'TID')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'TicketNo')
  String? get ticketNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'RouteNm')
  String? get routeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'FromStation')
  String? get fromStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'ToStation')
  String? get toStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'EntyDate')
  String? get entryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'TripDate')
  String? get tripDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'CurrencyType')
  String? get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'TName')
  String? get travelerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'SeatNo')
  String? get seatNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'Gender')
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'CancelAllow')
  String? get cancelAllowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsCancel')
  String? get isCanceled => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsCheck')
  String? get isChecked => throw _privateConstructorUsedError;
  @JsonKey(name: 'Fare')
  String? get fare => throw _privateConstructorUsedError;

  /// Serializes this TicketEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketEntityCopyWith<TicketEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketEntityCopyWith<$Res> {
  factory $TicketEntityCopyWith(
    TicketEntity value,
    $Res Function(TicketEntity) then,
  ) = _$TicketEntityCopyWithImpl<$Res, TicketEntity>;
  @useResult
  $Res call({
    @JsonKey(name: 'TID') String? id,
    @JsonKey(name: 'TicketNo') String? ticketNo,
    @JsonKey(name: 'RouteNm') String? routeName,
    @JsonKey(name: 'FromStation') String? fromStation,
    @JsonKey(name: 'ToStation') String? toStation,
    @JsonKey(name: 'EntyDate') String? entryDate,
    @JsonKey(name: 'TripDate') String? tripDate,
    @JsonKey(name: 'CurrencyType') String? currency,
    @JsonKey(name: 'TName') String? travelerName,
    @JsonKey(name: 'SeatNo') String? seatNo,
    @JsonKey(name: 'Gender') String? gender,
    @JsonKey(name: 'CancelAllow') String? cancelAllowed,
    @JsonKey(name: 'IsCancel') String? isCanceled,
    @JsonKey(name: 'IsCheck') String? isChecked,
    @JsonKey(name: 'Fare') String? fare,
  });
}

/// @nodoc
class _$TicketEntityCopyWithImpl<$Res, $Val extends TicketEntity>
    implements $TicketEntityCopyWith<$Res> {
  _$TicketEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketNo = freezed,
    Object? routeName = freezed,
    Object? fromStation = freezed,
    Object? toStation = freezed,
    Object? entryDate = freezed,
    Object? tripDate = freezed,
    Object? currency = freezed,
    Object? travelerName = freezed,
    Object? seatNo = freezed,
    Object? gender = freezed,
    Object? cancelAllowed = freezed,
    Object? isCanceled = freezed,
    Object? isChecked = freezed,
    Object? fare = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            ticketNo:
                freezed == ticketNo
                    ? _value.ticketNo
                    : ticketNo // ignore: cast_nullable_to_non_nullable
                        as String?,
            routeName:
                freezed == routeName
                    ? _value.routeName
                    : routeName // ignore: cast_nullable_to_non_nullable
                        as String?,
            fromStation:
                freezed == fromStation
                    ? _value.fromStation
                    : fromStation // ignore: cast_nullable_to_non_nullable
                        as String?,
            toStation:
                freezed == toStation
                    ? _value.toStation
                    : toStation // ignore: cast_nullable_to_non_nullable
                        as String?,
            entryDate:
                freezed == entryDate
                    ? _value.entryDate
                    : entryDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            tripDate:
                freezed == tripDate
                    ? _value.tripDate
                    : tripDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            currency:
                freezed == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String?,
            travelerName:
                freezed == travelerName
                    ? _value.travelerName
                    : travelerName // ignore: cast_nullable_to_non_nullable
                        as String?,
            seatNo:
                freezed == seatNo
                    ? _value.seatNo
                    : seatNo // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            cancelAllowed:
                freezed == cancelAllowed
                    ? _value.cancelAllowed
                    : cancelAllowed // ignore: cast_nullable_to_non_nullable
                        as String?,
            isCanceled:
                freezed == isCanceled
                    ? _value.isCanceled
                    : isCanceled // ignore: cast_nullable_to_non_nullable
                        as String?,
            isChecked:
                freezed == isChecked
                    ? _value.isChecked
                    : isChecked // ignore: cast_nullable_to_non_nullable
                        as String?,
            fare:
                freezed == fare
                    ? _value.fare
                    : fare // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketEntityImplCopyWith<$Res>
    implements $TicketEntityCopyWith<$Res> {
  factory _$$TicketEntityImplCopyWith(
    _$TicketEntityImpl value,
    $Res Function(_$TicketEntityImpl) then,
  ) = __$$TicketEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'TID') String? id,
    @JsonKey(name: 'TicketNo') String? ticketNo,
    @JsonKey(name: 'RouteNm') String? routeName,
    @JsonKey(name: 'FromStation') String? fromStation,
    @JsonKey(name: 'ToStation') String? toStation,
    @JsonKey(name: 'EntyDate') String? entryDate,
    @JsonKey(name: 'TripDate') String? tripDate,
    @JsonKey(name: 'CurrencyType') String? currency,
    @JsonKey(name: 'TName') String? travelerName,
    @JsonKey(name: 'SeatNo') String? seatNo,
    @JsonKey(name: 'Gender') String? gender,
    @JsonKey(name: 'CancelAllow') String? cancelAllowed,
    @JsonKey(name: 'IsCancel') String? isCanceled,
    @JsonKey(name: 'IsCheck') String? isChecked,
    @JsonKey(name: 'Fare') String? fare,
  });
}

/// @nodoc
class __$$TicketEntityImplCopyWithImpl<$Res>
    extends _$TicketEntityCopyWithImpl<$Res, _$TicketEntityImpl>
    implements _$$TicketEntityImplCopyWith<$Res> {
  __$$TicketEntityImplCopyWithImpl(
    _$TicketEntityImpl _value,
    $Res Function(_$TicketEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ticketNo = freezed,
    Object? routeName = freezed,
    Object? fromStation = freezed,
    Object? toStation = freezed,
    Object? entryDate = freezed,
    Object? tripDate = freezed,
    Object? currency = freezed,
    Object? travelerName = freezed,
    Object? seatNo = freezed,
    Object? gender = freezed,
    Object? cancelAllowed = freezed,
    Object? isCanceled = freezed,
    Object? isChecked = freezed,
    Object? fare = freezed,
  }) {
    return _then(
      _$TicketEntityImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        ticketNo:
            freezed == ticketNo
                ? _value.ticketNo
                : ticketNo // ignore: cast_nullable_to_non_nullable
                    as String?,
        routeName:
            freezed == routeName
                ? _value.routeName
                : routeName // ignore: cast_nullable_to_non_nullable
                    as String?,
        fromStation:
            freezed == fromStation
                ? _value.fromStation
                : fromStation // ignore: cast_nullable_to_non_nullable
                    as String?,
        toStation:
            freezed == toStation
                ? _value.toStation
                : toStation // ignore: cast_nullable_to_non_nullable
                    as String?,
        entryDate:
            freezed == entryDate
                ? _value.entryDate
                : entryDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        tripDate:
            freezed == tripDate
                ? _value.tripDate
                : tripDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        currency:
            freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String?,
        travelerName:
            freezed == travelerName
                ? _value.travelerName
                : travelerName // ignore: cast_nullable_to_non_nullable
                    as String?,
        seatNo:
            freezed == seatNo
                ? _value.seatNo
                : seatNo // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        cancelAllowed:
            freezed == cancelAllowed
                ? _value.cancelAllowed
                : cancelAllowed // ignore: cast_nullable_to_non_nullable
                    as String?,
        isCanceled:
            freezed == isCanceled
                ? _value.isCanceled
                : isCanceled // ignore: cast_nullable_to_non_nullable
                    as String?,
        isChecked:
            freezed == isChecked
                ? _value.isChecked
                : isChecked // ignore: cast_nullable_to_non_nullable
                    as String?,
        fare:
            freezed == fare
                ? _value.fare
                : fare // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketEntityImpl extends _TicketEntity {
  const _$TicketEntityImpl({
    @JsonKey(name: 'TID') this.id,
    @JsonKey(name: 'TicketNo') this.ticketNo,
    @JsonKey(name: 'RouteNm') this.routeName,
    @JsonKey(name: 'FromStation') this.fromStation,
    @JsonKey(name: 'ToStation') this.toStation,
    @JsonKey(name: 'EntyDate') this.entryDate,
    @JsonKey(name: 'TripDate') this.tripDate,
    @JsonKey(name: 'CurrencyType') this.currency,
    @JsonKey(name: 'TName') this.travelerName,
    @JsonKey(name: 'SeatNo') this.seatNo,
    @JsonKey(name: 'Gender') this.gender,
    @JsonKey(name: 'CancelAllow') this.cancelAllowed,
    @JsonKey(name: 'IsCancel') this.isCanceled,
    @JsonKey(name: 'IsCheck') this.isChecked,
    @JsonKey(name: 'Fare') this.fare,
  }) : super._();

  factory _$TicketEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketEntityImplFromJson(json);

  @override
  @JsonKey(name: 'TID')
  final String? id;
  @override
  @JsonKey(name: 'TicketNo')
  final String? ticketNo;
  @override
  @JsonKey(name: 'RouteNm')
  final String? routeName;
  @override
  @JsonKey(name: 'FromStation')
  final String? fromStation;
  @override
  @JsonKey(name: 'ToStation')
  final String? toStation;
  @override
  @JsonKey(name: 'EntyDate')
  final String? entryDate;
  @override
  @JsonKey(name: 'TripDate')
  final String? tripDate;
  @override
  @JsonKey(name: 'CurrencyType')
  final String? currency;
  @override
  @JsonKey(name: 'TName')
  final String? travelerName;
  @override
  @JsonKey(name: 'SeatNo')
  final String? seatNo;
  @override
  @JsonKey(name: 'Gender')
  final String? gender;
  @override
  @JsonKey(name: 'CancelAllow')
  final String? cancelAllowed;
  @override
  @JsonKey(name: 'IsCancel')
  final String? isCanceled;
  @override
  @JsonKey(name: 'IsCheck')
  final String? isChecked;
  @override
  @JsonKey(name: 'Fare')
  final String? fare;

  @override
  String toString() {
    return 'TicketEntity(id: $id, ticketNo: $ticketNo, routeName: $routeName, fromStation: $fromStation, toStation: $toStation, entryDate: $entryDate, tripDate: $tripDate, currency: $currency, travelerName: $travelerName, seatNo: $seatNo, gender: $gender, cancelAllowed: $cancelAllowed, isCanceled: $isCanceled, isChecked: $isChecked, fare: $fare)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ticketNo, ticketNo) ||
                other.ticketNo == ticketNo) &&
            (identical(other.routeName, routeName) ||
                other.routeName == routeName) &&
            (identical(other.fromStation, fromStation) ||
                other.fromStation == fromStation) &&
            (identical(other.toStation, toStation) ||
                other.toStation == toStation) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.tripDate, tripDate) ||
                other.tripDate == tripDate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.travelerName, travelerName) ||
                other.travelerName == travelerName) &&
            (identical(other.seatNo, seatNo) || other.seatNo == seatNo) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.cancelAllowed, cancelAllowed) ||
                other.cancelAllowed == cancelAllowed) &&
            (identical(other.isCanceled, isCanceled) ||
                other.isCanceled == isCanceled) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.fare, fare) || other.fare == fare));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    ticketNo,
    routeName,
    fromStation,
    toStation,
    entryDate,
    tripDate,
    currency,
    travelerName,
    seatNo,
    gender,
    cancelAllowed,
    isCanceled,
    isChecked,
    fare,
  );

  /// Create a copy of TicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketEntityImplCopyWith<_$TicketEntityImpl> get copyWith =>
      __$$TicketEntityImplCopyWithImpl<_$TicketEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketEntityImplToJson(this);
  }
}

abstract class _TicketEntity extends TicketEntity {
  const factory _TicketEntity({
    @JsonKey(name: 'TID') final String? id,
    @JsonKey(name: 'TicketNo') final String? ticketNo,
    @JsonKey(name: 'RouteNm') final String? routeName,
    @JsonKey(name: 'FromStation') final String? fromStation,
    @JsonKey(name: 'ToStation') final String? toStation,
    @JsonKey(name: 'EntyDate') final String? entryDate,
    @JsonKey(name: 'TripDate') final String? tripDate,
    @JsonKey(name: 'CurrencyType') final String? currency,
    @JsonKey(name: 'TName') final String? travelerName,
    @JsonKey(name: 'SeatNo') final String? seatNo,
    @JsonKey(name: 'Gender') final String? gender,
    @JsonKey(name: 'CancelAllow') final String? cancelAllowed,
    @JsonKey(name: 'IsCancel') final String? isCanceled,
    @JsonKey(name: 'IsCheck') final String? isChecked,
    @JsonKey(name: 'Fare') final String? fare,
  }) = _$TicketEntityImpl;
  const _TicketEntity._() : super._();

  factory _TicketEntity.fromJson(Map<String, dynamic> json) =
      _$TicketEntityImpl.fromJson;

  @override
  @JsonKey(name: 'TID')
  String? get id;
  @override
  @JsonKey(name: 'TicketNo')
  String? get ticketNo;
  @override
  @JsonKey(name: 'RouteNm')
  String? get routeName;
  @override
  @JsonKey(name: 'FromStation')
  String? get fromStation;
  @override
  @JsonKey(name: 'ToStation')
  String? get toStation;
  @override
  @JsonKey(name: 'EntyDate')
  String? get entryDate;
  @override
  @JsonKey(name: 'TripDate')
  String? get tripDate;
  @override
  @JsonKey(name: 'CurrencyType')
  String? get currency;
  @override
  @JsonKey(name: 'TName')
  String? get travelerName;
  @override
  @JsonKey(name: 'SeatNo')
  String? get seatNo;
  @override
  @JsonKey(name: 'Gender')
  String? get gender;
  @override
  @JsonKey(name: 'CancelAllow')
  String? get cancelAllowed;
  @override
  @JsonKey(name: 'IsCancel')
  String? get isCanceled;
  @override
  @JsonKey(name: 'IsCheck')
  String? get isChecked;
  @override
  @JsonKey(name: 'Fare')
  String? get fare;

  /// Create a copy of TicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketEntityImplCopyWith<_$TicketEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
