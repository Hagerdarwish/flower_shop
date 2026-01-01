import '../../../../app/core/api_manger/api_client.dart';
import '../../../../app/core/network/api_result.dart';
import '../../../../app/core/network/safe_api_call.dart';
import '../../data/product_details/datasource/product_details_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import '../../data/product_details/models/response/product_details_response.dart';

@LazySingleton(as: ProductDetailsRemoteDataSource)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiClient apiClient;

  ProductDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProductDetailsResponse>> getProductDetails(
      String productId) {
    return safeApiCall(
      call: () => apiClient.getProductDetails(productId),
    );
  }
}

