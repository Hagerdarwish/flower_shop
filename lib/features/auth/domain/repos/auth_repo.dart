import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';

abstract class AuthRepo {
  Future<ApiResult<SignupModel>> signup({
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? gender,
  });
}
