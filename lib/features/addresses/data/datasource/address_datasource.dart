import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/get_addresses_response.dart';

abstract class AddressDatasource {
  Future<ApiResult<GetAddressesResponse>?> getAddresses({
    required String token,
  });
}
