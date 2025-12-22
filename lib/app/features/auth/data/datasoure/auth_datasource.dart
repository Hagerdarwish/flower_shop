import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/data/models/request/reset_code_request_model/reset_code_request_model.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';
import '../models/response/reset_code_response_model/reset_code_response_model.dart';
import '../models/response/reset_password_response_model/reset_password_response_model.dart';

abstract class AuthDatasource {
  Future<ApiResult<ForgotPasswordResponse>?> forgotPassword(
      ForgotPasswordRequest request);

  Future<ApiResult<ResetCodeResponse>?> verifyResetCode(
      ResetCodeRequest request);

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      );

}
