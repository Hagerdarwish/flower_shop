import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';

import '../models/request/change-password-request-models/change-password-request-model.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../models/response/change-password-response-models/change-password-response-model.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';
import '../models/response/reset_password_response_model/reset_password_response_model.dart';
import '../models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<LoginResponse>?> login(LoginRequest loginRequest);

  Future<ApiResult<SignupDto>> signUp({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  });

  Future<ApiResult<ForgotPasswordResponse>?> forgotPassword(
    ForgotPasswordRequest request,
  );

  Future<ApiResult<VerifyResetCodeResponse>?> verifyResetCode(
    VerifyResetCodeRequest request,
  );

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  );

  Future<ApiResult<LogoutResponse>> logout({required String token});

  Future<ApiResult<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  );
}
