import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/request/forget_password_request_model/forget_password_request_model.dart';
import '../../data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../data/models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../../data/models/response/forget_password_response_model/forget_password_response_model.dart';
import '../../data/models/response/reset_password_response_model/reset_password_response_model.dart';
import '../../data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);
  @override
  Future<ApiResult<LoginResponse>?> login(LoginRequest loginRequest) {
    return safeApiCall<LoginResponse>(
      call: () => apiClient.login(loginRequest),
    );
  }

  @override
  Future<ApiResult<SignupDto>> signUp({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  }) {
    return safeApiCall<SignupDto>(
      call: () => apiClient.signUp({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'phone': phone,
        'gender': gender,
      }),
    );
  }

  @override
  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest request,
      ) {
    return safeApiCall(call: () => apiClient.forgotPassword(request));
  }

  @override
  Future<ApiResult<VerifyResetCodeResponse>> verifyResetCode(
      VerifyResetCodeRequest request) {
    return safeApiCall(
      call: () => apiClient.verifyResetCode(request),
    );
  }

  @override
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request) {
    return safeApiCall(
      call: () => apiClient.resetPassword(request),
    );
  }
}
