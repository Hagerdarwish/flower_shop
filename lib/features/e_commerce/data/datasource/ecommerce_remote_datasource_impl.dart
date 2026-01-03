import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/product_details_response.dart';
import 'package:injectable/injectable.dart';
import '../models/response/products_response.dart';
import 'ecommerce_remote_datasource.dart';

@Injectable(as: EcommerceRemoteDatasource)
class EcommerceRemoteDatasourceImpl implements EcommerceRemoteDatasource {
  ApiClient apiClient;

  EcommerceRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProductsResponse>> getProduct({
    String? occasion,
    String? category,
  }) {
    return safeApiCall(
      call: () => apiClient.getProducts(occasion: occasion, category: category),
    );
  }

  @override
  Future<ApiResult<AllCategoriesDto>> getAllCategories() {
    return safeApiCall(call: () => apiClient.getAllCategories());
  }

  @override
  Future<ApiResult<ProductDetailsResponse>> getProductDetails(
    String productId,
  ) {
    return safeApiCall(call: () => apiClient.getProductDetails(productId));
  }
}
