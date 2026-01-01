import 'package:flower_shop/app/core/network/api_result.dart';

import '../models/product_model.dart';

abstract class ProductRepo {
  Future<ApiResult<List<ProductModel>>> getProducts({String? occasion,String? category});
}
