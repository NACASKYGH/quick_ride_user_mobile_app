// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketEntityImpl _$$TicketEntityImplFromJson(Map<String, dynamic> json) =>
    _$TicketEntityImpl(
      id: json['TID'] as String?,
      ticketNo: json['TicketNo'] as String?,
      routeName: json['RouteNm'] as String?,
      fromStation: json['FromStation'] as String?,
      toStation: json['ToStation'] as String?,
      entryDate: json['EntyDate'] as String?,
      tripDate: json['TripDate'] as String?,
      currency: json['CurrencyType'] as String?,
      travelerName: json['TName'] as String?,
      seatNo: json['SeatNo'] as String?,
      gender: json['Gender'] as String?,
      cancelAllowed: json['CancelAllow'] as String?,
      isCanceled: json['IsCancel'] as String?,
      isChecked: json['IsCheck'] as String?,
      fare: json['Fare'] as String?,
    );

Map<String, dynamic> _$$TicketEntityImplToJson(_$TicketEntityImpl instance) =>
    <String, dynamic>{
      'TID': instance.id,
      'TicketNo': instance.ticketNo,
      'RouteNm': instance.routeName,
      'FromStation': instance.fromStation,
      'ToStation': instance.toStation,
      'EntyDate': instance.entryDate,
      'TripDate': instance.tripDate,
      'CurrencyType': instance.currency,
      'TName': instance.travelerName,
      'SeatNo': instance.seatNo,
      'Gender': instance.gender,
      'CancelAllow': instance.cancelAllowed,
      'IsCancel': instance.isCanceled,
      'IsCheck': instance.isChecked,
      'Fare': instance.fare,
    };
