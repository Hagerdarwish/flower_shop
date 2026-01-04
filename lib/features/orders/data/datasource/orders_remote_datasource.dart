import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';

abstract class OrdersRemoteDatasource {
  Future<ApiResult<UserCartsDto>> getUserCarts();
}
