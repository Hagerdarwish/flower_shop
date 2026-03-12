import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchOrderUseCase {
  final CheckoutRepo checkoutRepo;

  WatchOrderUseCase(this.checkoutRepo);

  Stream<OrderTracking?> execute(String orderId) {
    return checkoutRepo.watchOrder(orderId);
  }
}
