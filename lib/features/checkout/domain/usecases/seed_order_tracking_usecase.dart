import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SeedOrderTrackingUseCase {
  final CheckoutRepo _checkoutRepo;

  SeedOrderTrackingUseCase(this._checkoutRepo);

  Future<void> execute(CashOrderModel order) async {
    return _checkoutRepo.seedOrderTracking(order);
  }
}
