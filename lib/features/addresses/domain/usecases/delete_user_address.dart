import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteUserAddress {
  final AddressRepo addressRepo;

  DeleteUserAddress(this.addressRepo);

  Future<ApiResult<AddressResponse>> call(String token, String addressId) {
    return addressRepo.deleteAddress(token: token, addressId: addressId);
  }
}
