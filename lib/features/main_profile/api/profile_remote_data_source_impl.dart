import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/datasource/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileremoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileremoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProfileResponse>> getProfile(String token) {
    return safeApiCall(call: () => apiClient.getProfileData(token));
  }
}
