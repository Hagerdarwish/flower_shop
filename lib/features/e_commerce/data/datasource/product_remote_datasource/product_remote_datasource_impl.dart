import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:injectable/injectable.dart';

import '../../models/response/products_response.dart';
import 'product_remote_datasource.dart';

@Injectable(as: ProductRemoteDatasource)
class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  ApiClient apiClient;

  ProductRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProductsResponse>> getProduct({String? occasion}) {
    return safeApiCall(call: () => apiClient.getProducts(occasion: occasion));
  }
}
