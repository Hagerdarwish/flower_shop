import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:injectable/injectable.dart';

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
}
