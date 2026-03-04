import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/driver.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDriverUseCase {
  final CheckoutRepo checkoutRepo;

  GetDriverUseCase(this.checkoutRepo);

  Future<ApiResult<Driver>> execute(String driverId) {
    return checkoutRepo.getDriver(driverId);
  }
}
