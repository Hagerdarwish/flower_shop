import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<SignupDto>> signUp({
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? gender,
  });
}
