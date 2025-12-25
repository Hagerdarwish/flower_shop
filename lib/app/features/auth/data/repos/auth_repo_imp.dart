import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/forget_password_entity.dart';
import '../../domain/models/reset_password_entity.dart';
import '../../domain/models/verify_reset_code_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasoure/auth_datasource.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';
import '../models/response/reset_password_response_model/reset_password_response_model.dart';
import '../models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';

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

  @override
  Future<ApiResult<VerifyResetCodeEntity>> verifyResetCode(String code) async {
    final result = await authDatasource.verifyResetCode(
      VerifyResetCodeRequest(resetCode: code),
    );

    if (result is SuccessApiResult<VerifyResetCodeResponse>) {
      return SuccessApiResult(
        data: VerifyResetCodeEntity(status: result.data.status),
      );
    }
    if (result is ErrorApiResult<VerifyResetCodeResponse>) {
      return ErrorApiResult(error: result.error);
    };
    return ErrorApiResult(error: 'Unexpected error');

  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(ResetPasswordRequest request) async {
    final result = await authDatasource.resetPassword(
      request,
    );

    if (result is SuccessApiResult<ResetPasswordResponse>) {
      return SuccessApiResult(
        data: ResetPasswordEntity(message: result.data.message),
      );
    }
    if (result is ErrorApiResult<ResetPasswordResponse>) {
      return ErrorApiResult(error: result.error);
    };
    return ErrorApiResult(error: 'Unexpected error');

  }

}
