// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changePassrequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassRequest _$ChangePassRequestFromJson(Map<String, dynamic> json) =>
    ChangePassRequest(
      password: json['password'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ChangePassRequestToJson(ChangePassRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'newPassword': instance.newPassword,
    };
