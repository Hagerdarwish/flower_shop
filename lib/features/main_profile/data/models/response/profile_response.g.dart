// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      message: json['message'] as String?,
      profileUserModel: json['ProfileUserModel'] == null
          ? null
          : ProfileUserModel.fromJson(
              json['ProfileUserModel'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ProfileUserModel': instance.profileUserModel,
    };
