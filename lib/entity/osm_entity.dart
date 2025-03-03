import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'osm_entity.freezed.dart';
part 'osm_entity.g.dart';

@freezed
class OSMEntity with _$OSMEntity {
  const OSMEntity._();
  const factory OSMEntity({
    required String displayName,
    required num lat,
    required num lng,
  }) = _OSMEntity;

  factory OSMEntity.fromJson(Map<String, dynamic> json) =>
      _$OSMEntityFromJson(json);
}

@freezed
class LatLong with _$LatLong {
  const LatLong._();
  const factory LatLong({
    required num lat,
    required num lon,
  }) = _LatLong;

  factory LatLong.fromJson(Map<String, dynamic> json) =>
      _$LatLongFromJson(json);
}

@freezed
class PickedData with _$PickedData {
  const PickedData._();
  const factory PickedData({
    required String lat,
    required String lon,
    required OpenAddress address,
    String? name,
    String? type,
    num? importance,
    @JsonKey(name: 'place_id') required num placeId,
    @JsonKey(name: 'licence') String? license,
    @JsonKey(name: 'osm_type') String? osmType,
    @JsonKey(name: 'osm_id') num? osmId,
    @JsonKey(name: 'class') String? theClass,
    @JsonKey(name: 'addresstype') String? addressType,
    @JsonKey(name: 'place_rank') num? placeRank,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'boundingbox') @Default([]) List<String> boundingBox,
  }) = _PickedData;

  factory PickedData.fromJson(Map<String, dynamic> json) =>
      _$PickedDataFromJson(json);
}

@freezed
class OpenAddress with _$OpenAddress {
  const OpenAddress._();
  const factory OpenAddress({
    String? road,
    String? suburb,
    String? town,
    String? county,
    String? state,
    String? postcode,
    String? country,
    @JsonKey(name: 'country_code') String? countryCode,
    @JsonKey(name: 'ISO3166-2-lvl4') String? iso,
  }) = _OpenAddress;

  factory OpenAddress.fromJson(Map<String, dynamic> json) =>
      _$OpenAddressFromJson(json);
}
