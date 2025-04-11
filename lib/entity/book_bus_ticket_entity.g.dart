// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_bus_ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookBusTicketEntityImpl _$$BookBusTicketEntityImplFromJson(
  Map<String, dynamic> json,
) => _$BookBusTicketEntityImpl(
  success: json['success'] as bool? ?? false,
  message: json['Message'] as String?,
  url: json['Url'] as String?,
  ticketID: json['TicetID'] as String?,
);

Map<String, dynamic> _$$BookBusTicketEntityImplToJson(
  _$BookBusTicketEntityImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'Message': instance.message,
  'Url': instance.url,
  'TicetID': instance.ticketID,
};
