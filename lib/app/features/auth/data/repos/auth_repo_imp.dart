import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/forget_password_entity.dart';
import '../../domain/models/reset_code_entity.dart';
import '../../domain/models/reset_password_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasoure/auth_datasource.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/request/reset_code_request_model/reset_code_request_model.dart';
import '../models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';
import '../models/response/reset_code_response_model/reset_code_response_model.dart';
import '../models/response/reset_password_response_model/reset_password_response_model.dart';
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
      return ErrorApiResult(error: result.error);
    };
    return ErrorApiResult(error: 'Unexpected error');

  }

    @override
  Future<ApiResult<ResetCodeEntity>> verifyResetCode(String code) async {
    final result = await authDatasource.verifyResetCode(
      ResetCodeRequest(resetCode: code),
    );

    if (result is SuccessApiResult<ResetCodeResponse>) {
      return SuccessApiResult(
        data: ResetCodeEntity(status: result.data.status),
      );
    }
    if (result is ErrorApiResult<ResetCodeResponse>) {
      return ErrorApiResult(error: result.error);
    };
    return ErrorApiResult(error: 'Unexpected error');

    }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
      String email,
      String newPassword,
      ) async {
    final result = await authDatasource.resetPassword(
      ResetPasswordRequest(
        email: email,
        newPassword: newPassword,
      ),
    );

    if (result is SuccessApiResult<ResetPasswordResponse>) {
      return SuccessApiResult(
        data: ResetPasswordEntity(
          message: result.data.message,
          token: result.data.token,
        ),
      );
    }

    if (result is ErrorApiResult<ResetPasswordResponse>) {
      return ErrorApiResult(error: result.error);
    }

    return ErrorApiResult(error: 'Unexpected error');
  }
}
