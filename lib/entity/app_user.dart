import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: invalid_annotation_target

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser({
    @JsonKey(name: 'TokenNo') String? token,
    @JsonKey(name: 'PassID') String? id,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'EmailID') String? email,
    @JsonKey(name: 'PhotoPic') String? avatar,
    @JsonKey(name: 'Gender') String? gender,
    @JsonKey(name: 'DOB') String? dateOfBirth,
    @JsonKey(name: 'MobileNo') String? phone,
    @JsonKey(name: 'Kname') String? kinName,
    @JsonKey(name: 'Kmob') String? kinNumbers,
    @JsonKey(name: 'Age') String? age,
    @JsonKey(name: 'IDType') @Default('0') String? idType,
    @JsonKey(name: 'IDNo') @Default('') String? idNumber,
    @JsonKey(name: 'Citizenship') @Default('0') String? citizenship,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
