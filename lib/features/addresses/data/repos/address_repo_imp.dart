import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/get_addresses_response.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';

class AddressRepoImp implements AddressRepo {
  final AddressDatasource addressDatasource;
  AddressRepoImp({required this.addressDatasource});

  @override
  Future<ApiResult<GetAddressesResponse>> getAddresses({
    required String token,
  }) async {
    final result = await addressDatasource.getAddresses(token: token);
    if (result is SuccessApiResult<GetAddressesResponse>) {
      return SuccessApiResult<GetAddressesResponse>(data: result.data);
    }
    if (result is ErrorApiResult<GetAddressesResponse>) {
      return ErrorApiResult<GetAddressesResponse>(error: result.error);
    }
    return ErrorApiResult<GetAddressesResponse>(error: 'Unknown error');
  }
}
