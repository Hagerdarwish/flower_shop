import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/e_commerce/domain/models/product_details_entity.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

abstract class EcommerceRepo {
  Future<ApiResult<List<ProductModel>>> getProducts({
    String? occasion,
    String? category,
  });
  
  Future<ApiResult<AllCategoriesModel>> getAllCategories();

  Future<ApiResult<ProductDetailsEntity>> getProductDetails(String productId);
}
