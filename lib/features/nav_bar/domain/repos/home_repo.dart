import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';

abstract class HomeRepo {
  Future<ApiResult<List<ProductModel>>> getProducts({String? occasion});
}
