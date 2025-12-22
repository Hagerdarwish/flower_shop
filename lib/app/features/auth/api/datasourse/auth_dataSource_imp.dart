import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/app/features/auth/data/models/request/forget_password_request_model/forget_password_request_model.dart';
import 'package:flower_shop/app/features/auth/data/models/request/reset_code_request_model/reset_code_request_model.dart';
import 'package:flower_shop/app/features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import 'package:flower_shop/app/features/auth/data/models/response/reset_code_response_model/reset_code_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasoure/auth_datasource.dart';

@Injectable(as: AuthDatasource)
class AuthDatasourceImp extends AuthDatasource {
  final ApiClient apiClient;
  AuthDatasourceImp(this.apiClient);

  @override
  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest request) {
    return safeApiCall(
      call: () => apiClient.forgotPassword(request),
    );
  }

  @override
  Future<ApiResult<ResetCodeResponse>> verifyResetCode(
      ResetCodeRequest request) {
    return safeApiCall(
      call: () => apiClient.verifyResetCode(request),
    );
  }
}