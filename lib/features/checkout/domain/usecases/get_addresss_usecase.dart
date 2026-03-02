// lib/features/main_profile/domain/usecase/get_current_user_usecase.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressUsecase {
  final CheckoutRepo repo;

  GetAddressUsecase(this.repo);

  Future<ApiResult<List<AddressModel>>> call(String token) async {
    return await repo.getAddress(token);
  }
}
