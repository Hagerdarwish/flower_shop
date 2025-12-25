import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginModel>> login(String email, String password);

  Future<ApiResult<SignupModel>> signup({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  });
}
