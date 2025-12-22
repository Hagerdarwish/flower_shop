import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<SignupDto>> signUp({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  });
}
