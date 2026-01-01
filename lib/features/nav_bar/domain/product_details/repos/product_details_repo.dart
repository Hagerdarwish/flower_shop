import '../../../../../app/core/network/api_result.dart';
import '../models/product_details_entity.dart';

abstract class ProductDetailsRepo {
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(
      String productId);
}

