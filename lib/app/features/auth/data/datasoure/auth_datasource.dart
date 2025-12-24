import 'package:flower_shop/app/core/network/api_result.dart';
import '../models/request/forget_password_request_model/forget_password_request_model.dart';
import '../models/response/forget_password_response_model/forget_password_response_model.dart';

abstract class AuthDatasource {
  Future<ApiResult<ForgotPasswordResponse>?> forgotPassword(
      ForgotPasswordRequest request);}
