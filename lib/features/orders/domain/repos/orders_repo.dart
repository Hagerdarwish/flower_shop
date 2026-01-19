import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';

abstract class OrdersRepo {
  Future<ApiResult<UserCartsModel>> getUserCarts();

  Future<ApiResult<UserCartsModel>> addProductToCart({
    String? product,
    int? quantity,
  });

  Future<ApiResult<UserCartsModel>> deleteCartItem({String? cartItemId});

  Future<ApiResult<UserCartsModel>> updateCartItemQuantity({
    String? cartItemId,
    int? quantity,
  });
}
