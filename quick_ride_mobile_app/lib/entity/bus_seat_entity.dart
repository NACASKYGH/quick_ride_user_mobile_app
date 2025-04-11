import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'bus_seat_entity.freezed.dart';
part 'bus_seat_entity.g.dart';

@freezed
class BusSeatEntity with _$BusSeatEntity {
  const BusSeatEntity._();
  const factory BusSeatEntity({
    @JsonKey(name: 'ID') String? id,
    @JsonKey(name: 'Postion') String? position,
    @JsonKey(name: 'SeartNo') String? seatNumber,
    @JsonKey(name: 'StatusShow') String? statusShow,
    @JsonKey(name: 'BookStatus') String? bookStatus,
    @JsonKey(name: 'price') String? price,
    @JsonKey(name: 'BlockSeat') String? blockSeat,
  }) = _BusSeatEntity;

  factory BusSeatEntity.fromJson(Map<String, dynamic> json) =>
      _$BusSeatEntityFromJson(json);
}
