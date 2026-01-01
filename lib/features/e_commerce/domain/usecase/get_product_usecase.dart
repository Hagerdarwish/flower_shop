import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/models/product_model.dart';
import 'package:injectable/injectable.dart';
import '../repos/product_repo.dart';

@injectable
class GetProductUsecase {
  final ProductRepo _productRepo;
  GetProductUsecase(this._productRepo);

  Future<ApiResult<List<ProductModel>>> call({
    String? occasion,
    String? category,
  }) async {
    return await _productRepo.getProducts(occasion: occasion, category: category);
  }
}
