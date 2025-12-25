import 'package:flower_shop/features/auth/data/models/user_model.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "token")
  final String? token;

  LoginResponse({this.message, this.user, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }

LoginModel toEntity() {
  return LoginModel(
    message: message ?? '',
    token: token ?? '',
    user: user?.toEntity() ?? UserModel(
      id: '',
      firstName: '',
      lastName: null,
      email: '',
      photo: null,
      role: '',
      wishlist: [],
    ),
  );
}
}
