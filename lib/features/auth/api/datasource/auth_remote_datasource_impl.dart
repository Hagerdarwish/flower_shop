import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);

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
    final Map<String, dynamic> body = {};

  if (firstName != null) body['firstName'] = firstName;
  if (lastName != null) body['lastName'] = lastName;
  if (email != null) body['email'] = email;
  if (password != null) body['password'] = password;
  if (rePassword != null) body['rePassword'] = rePassword;
  if (phone != null) body['phone'] = phone;
  if (gender != null) body['gender'] = gender;

return safeApiCall<SignupDto>(
      call: () =>  apiClient.signUp(body),
    );

    // return safeApiCall<SignupDto>(
    //   call: () => apiClient.signUp({
    //     'firstName': firstName!,
    //     'lastName': lastName!,
    //     'email': email!,
    //     'password': password!,
    //     'rePassword': rePassword!,
    //     'phone': phone!,
    //     'gender': gender!,
    //   }),
    // );
  }
}
