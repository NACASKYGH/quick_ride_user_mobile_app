import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'cancelled_ticket_entity.freezed.dart';
part 'cancelled_ticket_entity.g.dart';

@freezed
class CancelledTicketEntity with _$CancelledTicketEntity {
  const CancelledTicketEntity._();

  const factory CancelledTicketEntity({
    @JsonKey(name: 'CancelCode') String? cancelCode,
    @JsonKey(name: 'TicketNo') String? ticketNo,
    @JsonKey(name: 'CancelDate') String? cancelDate,
    @JsonKey(name: 'CanName') String? canName,
    @JsonKey(name: 'TicketAmt') String? ticketAmt,
    @JsonKey(name: 'CancelAmt') String? cancelAmt,
    @JsonKey(name: 'RefundAmt') String? refundAmt,
    @JsonKey(name: 'PaymentStatus') String? paymentStatus,
  }) = _CancelledTicketEntity;

  factory CancelledTicketEntity.fromJson(Map<String, dynamic> json) =>
      _$CancelledTicketEntityFromJson(json);
}
