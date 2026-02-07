import 'package:flower_shop/features/e_commerce/domain/repos/ecommerce_repo.dart';
import '../../../../app/core/network/api_result.dart';
import '../models/product_details_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductDetailsUseCase {
  final EcommerceRepo repo;

  GetProductDetailsUseCase(this.repo);

  Future<ApiResult<ProductDetailsEntity>> call(String productId) {
    return repo.getProductDetails(productId);
  }
}
