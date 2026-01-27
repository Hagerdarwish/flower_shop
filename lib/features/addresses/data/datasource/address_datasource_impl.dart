import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/get_addresses_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDatasource)
class AddressDatasourceImpl extends AddressDatasource {
  ApiClient apiClient;
  AddressDatasourceImpl(this.apiClient);
  @override
  Future<ApiResult<GetAddressesResponse>?> getAddresses({
    required String token,
  }) {
    return safeApiCall(call: () => apiClient.getAddresses(token: token));
  }
}
