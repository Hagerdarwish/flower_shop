import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditUserAddress {
  final AddressRepo addressRepo;
  EditUserAddress(this.addressRepo);

  Future<ApiResult<List<AddressEntity>>> call({
    required String token,
    required String addressId,
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    String? username,
  }) {
    return addressRepo.editAddress(
      token: token,
      addressId: addressId,
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
