// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cancelled_ticket_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CancelledTicketEntity _$CancelledTicketEntityFromJson(
  Map<String, dynamic> json,
) {
  return _CancelledTicketEntity.fromJson(json);
}

/// @nodoc
mixin _$CancelledTicketEntity {
  @JsonKey(name: 'CancelCode')
  String? get cancelCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'TicketNo')
  String? get ticketNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'CancelDate')
  String? get cancelDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'CanName')
  String? get canName => throw _privateConstructorUsedError;
  @JsonKey(name: 'TicketAmt')
  String? get ticketAmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'CancelAmt')
  String? get cancelAmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'RefundAmt')
  String? get refundAmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'PaymentStatus')
  String? get paymentStatus => throw _privateConstructorUsedError;

  /// Serializes this CancelledTicketEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CancelledTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CancelledTicketEntityCopyWith<CancelledTicketEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelledTicketEntityCopyWith<$Res> {
  factory $CancelledTicketEntityCopyWith(
    CancelledTicketEntity value,
    $Res Function(CancelledTicketEntity) then,
  ) = _$CancelledTicketEntityCopyWithImpl<$Res, CancelledTicketEntity>;
  @useResult
  $Res call({
    @JsonKey(name: 'CancelCode') String? cancelCode,
    @JsonKey(name: 'TicketNo') String? ticketNo,
    @JsonKey(name: 'CancelDate') String? cancelDate,
    @JsonKey(name: 'CanName') String? canName,
    @JsonKey(name: 'TicketAmt') String? ticketAmt,
    @JsonKey(name: 'CancelAmt') String? cancelAmt,
    @JsonKey(name: 'RefundAmt') String? refundAmt,
    @JsonKey(name: 'PaymentStatus') String? paymentStatus,
  });
}

/// @nodoc
class _$CancelledTicketEntityCopyWithImpl<
  $Res,
  $Val extends CancelledTicketEntity
>
    implements $CancelledTicketEntityCopyWith<$Res> {
  _$CancelledTicketEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CancelledTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cancelCode = freezed,
    Object? ticketNo = freezed,
    Object? cancelDate = freezed,
    Object? canName = freezed,
    Object? ticketAmt = freezed,
    Object? cancelAmt = freezed,
    Object? refundAmt = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            cancelCode:
                freezed == cancelCode
                    ? _value.cancelCode
                    : cancelCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            ticketNo:
                freezed == ticketNo
                    ? _value.ticketNo
                    : ticketNo // ignore: cast_nullable_to_non_nullable
                        as String?,
            cancelDate:
                freezed == cancelDate
                    ? _value.cancelDate
                    : cancelDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            canName:
                freezed == canName
                    ? _value.canName
                    : canName // ignore: cast_nullable_to_non_nullable
                        as String?,
            ticketAmt:
                freezed == ticketAmt
                    ? _value.ticketAmt
                    : ticketAmt // ignore: cast_nullable_to_non_nullable
                        as String?,
            cancelAmt:
                freezed == cancelAmt
                    ? _value.cancelAmt
                    : cancelAmt // ignore: cast_nullable_to_non_nullable
                        as String?,
            refundAmt:
                freezed == refundAmt
                    ? _value.refundAmt
                    : refundAmt // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentStatus:
                freezed == paymentStatus
                    ? _value.paymentStatus
                    : paymentStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CancelledTicketEntityImplCopyWith<$Res>
    implements $CancelledTicketEntityCopyWith<$Res> {
  factory _$$CancelledTicketEntityImplCopyWith(
    _$CancelledTicketEntityImpl value,
    $Res Function(_$CancelledTicketEntityImpl) then,
  ) = __$$CancelledTicketEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'CancelCode') String? cancelCode,
    @JsonKey(name: 'TicketNo') String? ticketNo,
    @JsonKey(name: 'CancelDate') String? cancelDate,
    @JsonKey(name: 'CanName') String? canName,
    @JsonKey(name: 'TicketAmt') String? ticketAmt,
    @JsonKey(name: 'CancelAmt') String? cancelAmt,
    @JsonKey(name: 'RefundAmt') String? refundAmt,
    @JsonKey(name: 'PaymentStatus') String? paymentStatus,
  });
}

/// @nodoc
class __$$CancelledTicketEntityImplCopyWithImpl<$Res>
    extends
        _$CancelledTicketEntityCopyWithImpl<$Res, _$CancelledTicketEntityImpl>
    implements _$$CancelledTicketEntityImplCopyWith<$Res> {
  __$$CancelledTicketEntityImplCopyWithImpl(
    _$CancelledTicketEntityImpl _value,
    $Res Function(_$CancelledTicketEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CancelledTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cancelCode = freezed,
    Object? ticketNo = freezed,
    Object? cancelDate = freezed,
    Object? canName = freezed,
    Object? ticketAmt = freezed,
    Object? cancelAmt = freezed,
    Object? refundAmt = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(
      _$CancelledTicketEntityImpl(
        cancelCode:
            freezed == cancelCode
                ? _value.cancelCode
                : cancelCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        ticketNo:
            freezed == ticketNo
                ? _value.ticketNo
                : ticketNo // ignore: cast_nullable_to_non_nullable
                    as String?,
        cancelDate:
            freezed == cancelDate
                ? _value.cancelDate
                : cancelDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        canName:
            freezed == canName
                ? _value.canName
                : canName // ignore: cast_nullable_to_non_nullable
                    as String?,
        ticketAmt:
            freezed == ticketAmt
                ? _value.ticketAmt
                : ticketAmt // ignore: cast_nullable_to_non_nullable
                    as String?,
        cancelAmt:
            freezed == cancelAmt
                ? _value.cancelAmt
                : cancelAmt // ignore: cast_nullable_to_non_nullable
                    as String?,
        refundAmt:
            freezed == refundAmt
                ? _value.refundAmt
                : refundAmt // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentStatus:
            freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelledTicketEntityImpl extends _CancelledTicketEntity {
  const _$CancelledTicketEntityImpl({
    @JsonKey(name: 'CancelCode') this.cancelCode,
    @JsonKey(name: 'TicketNo') this.ticketNo,
    @JsonKey(name: 'CancelDate') this.cancelDate,
    @JsonKey(name: 'CanName') this.canName,
    @JsonKey(name: 'TicketAmt') this.ticketAmt,
    @JsonKey(name: 'CancelAmt') this.cancelAmt,
    @JsonKey(name: 'RefundAmt') this.refundAmt,
    @JsonKey(name: 'PaymentStatus') this.paymentStatus,
  }) : super._();

  factory _$CancelledTicketEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelledTicketEntityImplFromJson(json);

  @override
  @JsonKey(name: 'CancelCode')
  final String? cancelCode;
  @override
  @JsonKey(name: 'TicketNo')
  final String? ticketNo;
  @override
  @JsonKey(name: 'CancelDate')
  final String? cancelDate;
  @override
  @JsonKey(name: 'CanName')
  final String? canName;
  @override
  @JsonKey(name: 'TicketAmt')
  final String? ticketAmt;
  @override
  @JsonKey(name: 'CancelAmt')
  final String? cancelAmt;
  @override
  @JsonKey(name: 'RefundAmt')
  final String? refundAmt;
  @override
  @JsonKey(name: 'PaymentStatus')
  final String? paymentStatus;

  @override
  String toString() {
    return 'CancelledTicketEntity(cancelCode: $cancelCode, ticketNo: $ticketNo, cancelDate: $cancelDate, canName: $canName, ticketAmt: $ticketAmt, cancelAmt: $cancelAmt, refundAmt: $refundAmt, paymentStatus: $paymentStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelledTicketEntityImpl &&
            (identical(other.cancelCode, cancelCode) ||
                other.cancelCode == cancelCode) &&
            (identical(other.ticketNo, ticketNo) ||
                other.ticketNo == ticketNo) &&
            (identical(other.cancelDate, cancelDate) ||
                other.cancelDate == cancelDate) &&
            (identical(other.canName, canName) || other.canName == canName) &&
            (identical(other.ticketAmt, ticketAmt) ||
                other.ticketAmt == ticketAmt) &&
            (identical(other.cancelAmt, cancelAmt) ||
                other.cancelAmt == cancelAmt) &&
            (identical(other.refundAmt, refundAmt) ||
                other.refundAmt == refundAmt) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cancelCode,
    ticketNo,
    cancelDate,
    canName,
    ticketAmt,
    cancelAmt,
    refundAmt,
    paymentStatus,
  );

  /// Create a copy of CancelledTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelledTicketEntityImplCopyWith<_$CancelledTicketEntityImpl>
  get copyWith =>
      __$$CancelledTicketEntityImplCopyWithImpl<_$CancelledTicketEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelledTicketEntityImplToJson(this);
  }
}

abstract class _CancelledTicketEntity extends CancelledTicketEntity {
  const factory _CancelledTicketEntity({
    @JsonKey(name: 'CancelCode') final String? cancelCode,
    @JsonKey(name: 'TicketNo') final String? ticketNo,
    @JsonKey(name: 'CancelDate') final String? cancelDate,
    @JsonKey(name: 'CanName') final String? canName,
    @JsonKey(name: 'TicketAmt') final String? ticketAmt,
    @JsonKey(name: 'CancelAmt') final String? cancelAmt,
    @JsonKey(name: 'RefundAmt') final String? refundAmt,
    @JsonKey(name: 'PaymentStatus') final String? paymentStatus,
  }) = _$CancelledTicketEntityImpl;
  const _CancelledTicketEntity._() : super._();

  factory _CancelledTicketEntity.fromJson(Map<String, dynamic> json) =
      _$CancelledTicketEntityImpl.fromJson;

  @override
  @JsonKey(name: 'CancelCode')
  String? get cancelCode;
  @override
  @JsonKey(name: 'TicketNo')
  String? get ticketNo;
  @override
  @JsonKey(name: 'CancelDate')
  String? get cancelDate;
  @override
  @JsonKey(name: 'CanName')
  String? get canName;
  @override
  @JsonKey(name: 'TicketAmt')
  String? get ticketAmt;
  @override
  @JsonKey(name: 'CancelAmt')
  String? get cancelAmt;
  @override
  @JsonKey(name: 'RefundAmt')
  String? get refundAmt;
  @override
  @JsonKey(name: 'PaymentStatus')
  String? get paymentStatus;

  /// Create a copy of CancelledTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelledTicketEntityImplCopyWith<_$CancelledTicketEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
