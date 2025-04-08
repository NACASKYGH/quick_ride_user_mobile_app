import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'book_bus_ticket_entity.freezed.dart';
part 'book_bus_ticket_entity.g.dart';

@freezed
class BookBusTicketEntity with _$BookBusTicketEntity {
  const BookBusTicketEntity._();
  const factory BookBusTicketEntity({
    @Default(false) bool success,
    @JsonKey(name: 'Message') String? message,
    @JsonKey(name: 'Url') String? url,
    @JsonKey(name: 'TicetID') String? ticketID,
  }) = _BookBusTicketEntity;

  factory BookBusTicketEntity.fromJson(Map<String, dynamic> json) =>
      _$BookBusTicketEntityFromJson(json);
}
