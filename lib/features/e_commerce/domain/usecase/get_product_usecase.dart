import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:injectable/injectable.dart';
import '../repos/ecommerce_repo.dart';

@injectable
class GetProductUsecase {
  final EcommerceRepo _productRepo;
  GetProductUsecase(this._productRepo);

  Future<ApiResult<List<ProductModel>>> call({
    String? occasion,
    String? category,
  }) async {
    return await _productRepo.getProducts(
      occasion: occasion,
      category: category,
    );
  }
}
