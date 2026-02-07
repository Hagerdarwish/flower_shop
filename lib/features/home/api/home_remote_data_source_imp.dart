import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/home/data/datasource/home_remote_data_source.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp extends HomeRemoteDataSource {
  ApiClient apiClient;
  HomeRemoteDataSourceImp(this.apiClient);
  @override
  Future<ApiResult<HomeResponse>?> getHomeData() {
    return safeApiCall<HomeResponse>(call: () => apiClient.getHomeData());
  }
}
