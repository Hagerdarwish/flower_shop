import 'package:flower_shop/app/core/network/api_result.dart';
import '../models/forget_password_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<ForgotPasswordEntity>> forgotPassword(String email);}