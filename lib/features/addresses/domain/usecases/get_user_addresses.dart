import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserAddresses {
  final AddressRepo addressRepo;
  GetUserAddresses({required this.addressRepo});
  Future<ApiResult<List<AddressEntity>>> call({required String token}) {
    return addressRepo.getAddresses(token: token);
  }
}
