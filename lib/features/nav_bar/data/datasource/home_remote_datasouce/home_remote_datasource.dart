
import 'package:flower_shop/features/nav_bar/data/models/response/products_response.dart';

import '../../../../../app/core/network/api_result.dart';
import '../../../../auth/data/models/response/reset_password_response_model/reset_password_response_model.dart';

abstract class HomeRemoteDatasource {

  Future<ApiResult<ProductsResponse>> getProduct({String? occasion});
}