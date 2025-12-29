import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/nav_bar/data/models/response/products_response.dart';
import 'package:injectable/injectable.dart';
import 'home_remote_datasource.dart';

@Injectable(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  ApiClient apiClient;
  HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProductsResponse>> getProduct({String? occasion}) {
    return safeApiCall(call: () => apiClient.getProducts());

  }


}
