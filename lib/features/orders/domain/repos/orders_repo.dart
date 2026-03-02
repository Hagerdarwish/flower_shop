import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
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

  Future<ApiResult<PaymentResponse>> payment({
    required String token,
    required String returnUrl,
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
  });
}
