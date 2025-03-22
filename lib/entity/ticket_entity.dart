import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'ticket_entity.freezed.dart';
part 'ticket_entity.g.dart';

@freezed
class TicketEntity with _$TicketEntity {
  const TicketEntity._();

  const factory TicketEntity({
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
  }) = _TicketEntity;

  factory TicketEntity.fromJson(Map<String, dynamic> json) =>
      _$TicketEntityFromJson(json);
}
