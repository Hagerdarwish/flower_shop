import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/mappers/signup_dto_mapper.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRemoteDataSource remoteDataSource;
  AuthRepoImpl({required this.remoteDataSource});
  @override
  Future<ApiResult<SignupModel>> signup({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  }) async {
    ApiResult<SignupDto> signupResponse = await remoteDataSource.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
      gender: gender,
    );
    switch (signupResponse) {
      case SuccessApiResult<SignupDto>():
        SignupDto dto = signupResponse.data;
        SignupModel signupModel = dto.toSignupModel();
        return SuccessApiResult<SignupModel>(data: signupModel);
      case ErrorApiResult<SignupDto>():
        return ErrorApiResult<SignupModel>(
          error: signupResponse.error.toString(),
        );
    }
  }
}
