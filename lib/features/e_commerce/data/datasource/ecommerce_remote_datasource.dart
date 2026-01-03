import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/product_details_response.dart';
import '../../../../app/core/network/api_result.dart';
import '../models/response/products_response.dart';

abstract class EcommerceRemoteDatasource {
  Future<ApiResult<ProductsResponse>> getProduct({
    String? occasion,
    String? category,
  });

  Future<ApiResult<AllCategoriesDto>> getAllCategories();

  Future<ApiResult<ProductDetailsResponse>> getProductDetails(String productId);
}
