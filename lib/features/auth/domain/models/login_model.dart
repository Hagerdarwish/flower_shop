
import 'package:flower_shop/features/auth/domain/models/user_model.dart';

class LoginModel {
  final String message;
  final UserModel user;
  final String token;

  const LoginModel({
    required this.message,
    required this.user,
    required this.token,
  });
}
