import 'package:json_annotation/json_annotation.dart';

part 'signup_dto.g.dart';

@JsonSerializable()
class SignupDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'user')
  final UserDto? user;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'error')
  final String? error;

  SignupDto({this.message, this.user, this.token, this.error});

  factory SignupDto.fromJson(Map<String, dynamic> json) =>
      _$SignupDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignupDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'wishlist')
  final List<dynamic>? wishlist;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'addresses')
  final List<dynamic>? addresses;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  UserDto({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
