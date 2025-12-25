// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupDto _$SignupDtoFromJson(Map<String, dynamic> json) => SignupDto(
  message: json['message'] as String?,
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String?,
  error: json['error'] as String?,
);

Map<String, dynamic> _$SignupDtoToJson(SignupDto instance) => <String, dynamic>{
  'message': instance.message,
  'user': instance.user,
  'token': instance.token,
  'error': instance.error,
};

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  photo: json['photo'] as String?,
  role: json['role'] as String?,
  wishlist: json['wishlist'] as List<dynamic>?,
  id: json['_id'] as String?,
  addresses: json['addresses'] as List<dynamic>?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
  'photo': instance.photo,
  'role': instance.role,
  'wishlist': instance.wishlist,
  '_id': instance.id,
  'addresses': instance.addresses,
  'createdAt': instance.createdAt,
};
