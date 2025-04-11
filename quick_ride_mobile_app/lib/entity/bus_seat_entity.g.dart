// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_seat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusSeatEntityImpl _$$BusSeatEntityImplFromJson(Map<String, dynamic> json) =>
    _$BusSeatEntityImpl(
      id: json['ID'] as String?,
      position: json['Postion'] as String?,
      seatNumber: json['SeartNo'] as String?,
      statusShow: json['StatusShow'] as String?,
      bookStatus: json['BookStatus'] as String?,
      price: json['price'] as String?,
      blockSeat: json['BlockSeat'] as String?,
    );

Map<String, dynamic> _$$BusSeatEntityImplToJson(_$BusSeatEntityImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Postion': instance.position,
      'SeartNo': instance.seatNumber,
      'StatusShow': instance.statusShow,
      'BookStatus': instance.bookStatus,
      'price': instance.price,
      'BlockSeat': instance.blockSeat,
    };
