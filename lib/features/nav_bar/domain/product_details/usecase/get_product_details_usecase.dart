import '../../../../../app/core/network/api_result.dart';
import '../models/product_details_entity.dart';
import '../repos/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductDetailsUseCase {
  final ProductDetailsRepo repo;

  GetProductDetailsUseCase(this.repo);

  Future<ApiResult<ProductDetailsEntity>> call(String productId) {
    return repo.getProductDetails(productId);
  }
}

