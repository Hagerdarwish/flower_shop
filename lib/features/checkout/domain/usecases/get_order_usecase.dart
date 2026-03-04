import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderUseCase {
  final CheckoutRepo checkoutRepo;

  GetOrderUseCase(this.checkoutRepo);

  Future<ApiResult<OrderTracking>> execute(String orderId) {
    return checkoutRepo.getOrder(orderId);
  }
}
