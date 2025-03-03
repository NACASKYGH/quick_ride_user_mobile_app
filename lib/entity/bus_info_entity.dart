import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'bus_info_entity.g.dart';
part 'bus_info_entity.freezed.dart';

@freezed
class BusInfoEntity with _$BusInfoEntity {
  const BusInfoEntity._();
  const factory BusInfoEntity({
    @JsonKey(name: 'TripID') String? tripId,
    @JsonKey(name: 'TName') String? tName,
    @JsonKey(name: 'FromLocation') String? fromLocation,
    @JsonKey(name: 'ToLocation') String? toLocation,
    @JsonKey(name: 'DestFromID') String? fromLocationId,
    @JsonKey(name: 'DestToID') String? destinationId,
    @JsonKey(name: 'FAR') String? lorryFare,
    @JsonKey(name: 'Depart') String? departTime,
    @JsonKey(name: 'LSEAT') String? totalSeats,
    @JsonKey(name: 'logoURL') String? avatar,
    @JsonKey(name: 'BusType') String? busType,
    @JsonKey(name: 'TerminalName') String? terminalName,
    @JsonKey(name: 'BusNo') String? busNo,
  }) = _BusInfoEntity;

  factory BusInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$BusInfoEntityFromJson(json);
}
