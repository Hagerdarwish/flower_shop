import 'package:flower_shop/app/core/network/api_result.dart';

import '../models/forget_password_entity.dart';
import '../models/reset_code_entity.dart';
import '../models/reset_password_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email);

  Future<ApiResult<ResetCodeEntity>> verifyResetCode(String code);
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
      String email,
      String newPassword,
      );
}