import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/repos/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteCartItemUsecase {
  OrdersRepo ordersRepo;
  DeleteCartItemUsecase(this.ordersRepo);

  Future<ApiResult<UserCartsModel>> call({String? cartItemId}) =>
      ordersRepo.deleteCartItem(cartItemId: cartItemId);
}
