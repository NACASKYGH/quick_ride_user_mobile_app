// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancelled_ticket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CancelledTicketEntityImpl _$$CancelledTicketEntityImplFromJson(
  Map<String, dynamic> json,
) => _$CancelledTicketEntityImpl(
  cancelCode: json['CancelCode'] as String?,
  ticketNo: json['TicketNo'] as String?,
  cancelDate: json['CancelDate'] as String?,
  canName: json['CanName'] as String?,
  ticketAmt: json['TicketAmt'] as String?,
  cancelAmt: json['CancelAmt'] as String?,
  refundAmt: json['RefundAmt'] as String?,
  paymentStatus: json['PaymentStatus'] as String?,
);

Map<String, dynamic> _$$CancelledTicketEntityImplToJson(
  _$CancelledTicketEntityImpl instance,
) => <String, dynamic>{
  'CancelCode': instance.cancelCode,
  'TicketNo': instance.ticketNo,
  'CancelDate': instance.cancelDate,
  'CanName': instance.canName,
  'TicketAmt': instance.ticketAmt,
  'CancelAmt': instance.cancelAmt,
  'RefundAmt': instance.refundAmt,
  'PaymentStatus': instance.paymentStatus,
};
