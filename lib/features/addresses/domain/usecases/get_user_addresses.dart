import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserAddresses {
  final AddressRepo addressRepo;
  GetUserAddresses({required this.addressRepo});
  Future call({required String token}) {
    return addressRepo.getAddresses(token: token);
  }
}
