import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';

import '../../data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/forget_password_entity.dart';
import '../models/reset_password_entity.dart';
import '../models/verify_reset_code_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginModel>> login(String email, String password);

  Future<ApiResult<SignupModel>> signup({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  });

  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email);
  Future<ApiResult<VerifyResetCodeEntity>> verifyResetCode(String code);
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequest request,
  );
  Future<ApiResult<LogoutResponse>> logout({required String token});
}
