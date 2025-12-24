import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/forget_password_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasoure/auth_datasource.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDatasource authDatasource;
  AuthRepoImp(this.authDatasource);

  @override
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email) async {
    final result = await authDatasource.forgotPassword(
      ForgotPasswordRequest(email: email),
    );

    if (result is SuccessApiResult<ForgotPasswordResponse>) {
      return SuccessApiResult(
        data: ForgotPasswordEntity(
          message: result.data.message,
          info: result.data.info,
        ),
      );
    }

    if (result is ErrorApiResult<ForgotPasswordResponse>) {
      return ErrorApiResult<ForgotPasswordEntity>(error: result.error);
    };

    return ErrorApiResult<ForgotPasswordEntity>(error: 'Unexpected error');
  }
}
