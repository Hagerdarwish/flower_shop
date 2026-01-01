import '../../../../../app/core/network/api_result.dart';
import '../models/response/product_details_response.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ApiResult<ProductDetailsResponse>> getProductDetails(
      String productId);
}
