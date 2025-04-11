// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_bus_ticket_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BookBusTicketEntity _$BookBusTicketEntityFromJson(Map<String, dynamic> json) {
  return _BookBusTicketEntity.fromJson(json);
}

/// @nodoc
mixin _$BookBusTicketEntity {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'Message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'Url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'TicetID')
  String? get ticketID => throw _privateConstructorUsedError;

  /// Serializes this BookBusTicketEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookBusTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookBusTicketEntityCopyWith<BookBusTicketEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookBusTicketEntityCopyWith<$Res> {
  factory $BookBusTicketEntityCopyWith(
    BookBusTicketEntity value,
    $Res Function(BookBusTicketEntity) then,
  ) = _$BookBusTicketEntityCopyWithImpl<$Res, BookBusTicketEntity>;
  @useResult
  $Res call({
    bool success,
    @JsonKey(name: 'Message') String? message,
    @JsonKey(name: 'Url') String? url,
    @JsonKey(name: 'TicetID') String? ticketID,
  });
}

/// @nodoc
class _$BookBusTicketEntityCopyWithImpl<$Res, $Val extends BookBusTicketEntity>
    implements $BookBusTicketEntityCopyWith<$Res> {
  _$BookBusTicketEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookBusTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? url = freezed,
    Object? ticketID = freezed,
  }) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            url:
                freezed == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String?,
            ticketID:
                freezed == ticketID
                    ? _value.ticketID
                    : ticketID // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookBusTicketEntityImplCopyWith<$Res>
    implements $BookBusTicketEntityCopyWith<$Res> {
  factory _$$BookBusTicketEntityImplCopyWith(
    _$BookBusTicketEntityImpl value,
    $Res Function(_$BookBusTicketEntityImpl) then,
  ) = __$$BookBusTicketEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    @JsonKey(name: 'Message') String? message,
    @JsonKey(name: 'Url') String? url,
    @JsonKey(name: 'TicetID') String? ticketID,
  });
}

/// @nodoc
class __$$BookBusTicketEntityImplCopyWithImpl<$Res>
    extends _$BookBusTicketEntityCopyWithImpl<$Res, _$BookBusTicketEntityImpl>
    implements _$$BookBusTicketEntityImplCopyWith<$Res> {
  __$$BookBusTicketEntityImplCopyWithImpl(
    _$BookBusTicketEntityImpl _value,
    $Res Function(_$BookBusTicketEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BookBusTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? url = freezed,
    Object? ticketID = freezed,
  }) {
    return _then(
      _$BookBusTicketEntityImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        url:
            freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String?,
        ticketID:
            freezed == ticketID
                ? _value.ticketID
                : ticketID // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookBusTicketEntityImpl extends _BookBusTicketEntity {
  const _$BookBusTicketEntityImpl({
    this.success = false,
    @JsonKey(name: 'Message') this.message,
    @JsonKey(name: 'Url') this.url,
    @JsonKey(name: 'TicetID') this.ticketID,
  }) : super._();

  factory _$BookBusTicketEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookBusTicketEntityImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey(name: 'Message')
  final String? message;
  @override
  @JsonKey(name: 'Url')
  final String? url;
  @override
  @JsonKey(name: 'TicetID')
  final String? ticketID;

  @override
  String toString() {
    return 'BookBusTicketEntity(success: $success, message: $message, url: $url, ticketID: $ticketID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookBusTicketEntityImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.ticketID, ticketID) ||
                other.ticketID == ticketID));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, url, ticketID);

  /// Create a copy of BookBusTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookBusTicketEntityImplCopyWith<_$BookBusTicketEntityImpl> get copyWith =>
      __$$BookBusTicketEntityImplCopyWithImpl<_$BookBusTicketEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BookBusTicketEntityImplToJson(this);
  }
}

abstract class _BookBusTicketEntity extends BookBusTicketEntity {
  const factory _BookBusTicketEntity({
    final bool success,
    @JsonKey(name: 'Message') final String? message,
    @JsonKey(name: 'Url') final String? url,
    @JsonKey(name: 'TicetID') final String? ticketID,
  }) = _$BookBusTicketEntityImpl;
  const _BookBusTicketEntity._() : super._();

  factory _BookBusTicketEntity.fromJson(Map<String, dynamic> json) =
      _$BookBusTicketEntityImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'Message')
  String? get message;
  @override
  @JsonKey(name: 'Url')
  String? get url;
  @override
  @JsonKey(name: 'TicetID')
  String? get ticketID;

  /// Create a copy of BookBusTicketEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookBusTicketEntityImplCopyWith<_$BookBusTicketEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
