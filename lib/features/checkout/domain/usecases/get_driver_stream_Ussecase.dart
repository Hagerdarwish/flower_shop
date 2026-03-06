import 'package:flower_shop/features/checkout/domain/models/driver.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDriverStreamUseCase {
  final CheckoutRepo _checkoutRepo;

  GetDriverStreamUseCase(this._checkoutRepo);

  Stream<Driver?> execute(String driverId) {
    return _checkoutRepo.getDriverStream(driverId);
  }
}
