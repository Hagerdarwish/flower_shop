import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/orders/data/datasource/orders_remote_datasource.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDatasource)
class OrdersRemoteDatasourceImpl implements OrdersRemoteDatasource {
  ApiClient apiClient;
  OrdersRemoteDatasourceImpl(this.apiClient);
  @override
  Future<ApiResult<UserCartsDto>> getUserCarts() {
    return safeApiCall<UserCartsDto>(call: () => apiClient.getUserCarts());
  }

  @override
  Future<ApiResult<UserCartsDto>> addProductToCart({
    String? product,
    int? quantity,
  }) {
    return safeApiCall<UserCartsDto>(
      call: () => apiClient.addProductToCart({
        'product': product,
        'quantity': quantity,
      }),
    );
  }

  @override
  Future<ApiResult<UserCartsDto>> deleteCartItem({String? cartItemId}) {
    return safeApiCall<UserCartsDto>(
      call: () => apiClient.deleteCartItem(cartItemId!),
    );
  }

  @override
  Future<ApiResult<UserCartsDto>> updateCartItemQuantity({
    String? cartItemId,
    int? quantity,
  }) {
    return safeApiCall<UserCartsDto>(
      call: () =>
          apiClient.updateCartItemQuantity(cartItemId!, {'quantity': quantity}),
    );
  }
}
