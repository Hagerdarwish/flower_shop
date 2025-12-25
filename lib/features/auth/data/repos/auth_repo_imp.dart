import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/mappers/signup_dto_mapper.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthRemoteDataSource authDatasource;
  AuthRepoImp(this.authDatasource);

  @override
  Future<ApiResult<LoginModel>> login(String email, String password) async {
    final loginRequest = LoginRequest(email: email, password: password);
    final result = await authDatasource.login(loginRequest);
    if (result is SuccessApiResult<LoginResponse>) {
      return SuccessApiResult<LoginModel>(data: result.data.toEntity());
    }
    if (result is ErrorApiResult<LoginResponse>) {
      return ErrorApiResult<LoginModel>(error: result.error);
    }
    return ErrorApiResult<LoginModel>(error: 'Unknown error');
  }

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
    ApiResult<SignupDto> signupResponse = await authDatasource.signUp(
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
