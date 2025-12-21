// import 'package:flower_shop/app/core/api_manger/api_client.dart';
// import 'package:flower_shop/app/core/network/api_result.dart';
// import 'package:flower_shop/app/core/network/safe_api_call.dart';
// import 'package:flower_shop/features/auth/data/datasoure/auth_datasource.dart';
// import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart.dart';
// import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart.dart';
// import 'package:injectable/injectable.dart';

// @Injectable(as: AuthDatasource)
// class AuthDatasourceImp extends AuthDatasource {
//   final ApiClient apiClient;
//   AuthDatasourceImp(this.apiClient);

//   @override
//   Future<ApiResult<LoginResponse>?> login(LoginRequest loginRequest) {
//     return safeApiCall<LoginResponse>(
//       call: () => apiClient.login(loginRequest),
//     );
//   }
// }











import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/features/auth/data/datasoure/auth_datasource.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDatasource)
class AuthDatasourceImp extends AuthDatasource {
  final ApiClient apiClient;
  AuthDatasourceImp(this.apiClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return apiClient.login(loginRequest);
  }
}

