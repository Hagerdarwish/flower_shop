import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<SignupDto>> signUp({
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? gender,
  }) async {
    try {
      SignupDto signupResponse = await apiClient.signUp({
        'firstName': fName,
        'lastName': lName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phoneNumber,
        'gender': gender,
      });
      return SuccessApiResult<SignupDto>(data: signupResponse);
    } catch (e) {
      return ErrorApiResult<SignupDto>(error: e.toString());
    }
  }
}
