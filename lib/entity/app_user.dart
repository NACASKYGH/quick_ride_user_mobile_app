import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser({
    @JsonKey(name: 'PassID') String? id,
    @JsonKey(name: 'TokenNo') String? token,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'PhotoPic') String? avatar,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
