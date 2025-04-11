// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusInfoEntityImpl _$$BusInfoEntityImplFromJson(Map<String, dynamic> json) =>
    _$BusInfoEntityImpl(
      tripId: json['TripID'] as String?,
      tName: json['TName'] as String?,
      fromLocation: json['FromLocation'] as String?,
      toLocation: json['ToLocation'] as String?,
      fromLocationId: json['DestFromID'] as String?,
      destinationId: json['DestToID'] as String?,
      lorryFare: json['FAR'] as String?,
      departTime: json['Depart'] as String?,
      totalSeats: json['LSEAT'] as String?,
      avatar: json['logoURL'] as String?,
      busType: json['BusType'] as String?,
      terminalName: json['TerminalName'] as String?,
      busNo: json['BusNo'] as String?,
    );

Map<String, dynamic> _$$BusInfoEntityImplToJson(_$BusInfoEntityImpl instance) =>
    <String, dynamic>{
      'TripID': instance.tripId,
      'TName': instance.tName,
      'FromLocation': instance.fromLocation,
      'ToLocation': instance.toLocation,
      'DestFromID': instance.fromLocationId,
      'DestToID': instance.destinationId,
      'FAR': instance.lorryFare,
      'Depart': instance.departTime,
      'LSEAT': instance.totalSeats,
      'logoURL': instance.avatar,
      'BusType': instance.busType,
      'TerminalName': instance.terminalName,
      'BusNo': instance.busNo,
    };
