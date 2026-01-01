import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';

import '../models/product_model.dart';
import '../repos/product_repo.dart';

@injectable
class GetProductUsecase {
  final ProductRepo _homeRepo;

  GetProductUsecase(this._homeRepo);

  Future<ApiResult<List<ProductModel>>> call({String? occasion}) async {
    return await _homeRepo.getProducts(occasion: occasion);
  }
}
