import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';

abstract class OrdersRemoteDatasource {
  Future<ApiResult<UserCartsDto>> getUserCarts();

  Future<ApiResult<UserCartsDto>> addProductToCart({
    String? product,
    int? quantity,
  });

  Future<ApiResult<UserCartsDto>> deleteCartItem({String? cartItemId});

  Future<ApiResult<UserCartsDto>> updateCartItemQuantity({
    String? cartItemId,
    int? quantity,
  });
}
