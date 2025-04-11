// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      token: json['TokenNo'] as String?,
      id: json['PassID'] as String?,
      name: json['Name'] as String?,
      email: json['EmailID'] as String?,
      avatar: json['PhotoPic'] as String?,
      gender: json['Gender'] as String?,
      dateOfBirth: json['DOB'] as String?,
      phone: json['MobileNo'] as String?,
      kinName: json['Kname'] as String?,
      kinNumber: json['Kmob'] as String?,
      age: json['Age'] as String?,
      idType: json['IDType'] as String? ?? '0',
      idNumber: json['IDNo'] as String? ?? '',
      citizenship: json['Citizenship'] as String? ?? '0',
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'TokenNo': instance.token,
      'PassID': instance.id,
      'Name': instance.name,
      'EmailID': instance.email,
      'PhotoPic': instance.avatar,
      'Gender': instance.gender,
      'DOB': instance.dateOfBirth,
      'MobileNo': instance.phone,
      'Kname': instance.kinName,
      'Kmob': instance.kinNumber,
      'Age': instance.age,
      'IDType': instance.idType,
      'IDNo': instance.idNumber,
      'Citizenship': instance.citizenship,
    };
