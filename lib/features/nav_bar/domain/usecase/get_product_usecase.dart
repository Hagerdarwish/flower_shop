import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';
import 'package:injectable/injectable.dart';

import '../repos/home_repo.dart';

@injectable
class GetProductUsecase {
  final HomeRepo _homeRepo;
  GetProductUsecase(this._homeRepo);

  Future<ApiResult<List<ProductModel>>> call({String? occasion}) async {
    return await _homeRepo.getProducts(occasion: occasion);
  }
}