import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasoure/auth_datasource.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDatasource authDatasource;
  AuthRepoImp(this.authDatasource);

  @override
  Future<ApiResult<LoginModel>> login(String email, String password) async {
    final loginRequest = LoginRequest(
      email: email,
      password: password,
    );
    final result = await authDatasource.login(loginRequest);
    if (result is SuccessApiResult<LoginResponse>) {
      return SuccessApiResult<LoginModel>(
        data: result.data.toEntity(),
      );
    }
    if (result is ErrorApiResult<LoginResponse>) {
      return ErrorApiResult<LoginModel>(
        error: result.error,
      );
    }
    return ErrorApiResult<LoginModel>(
      error: 'Unknown error',
    );
  }
}
