import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/network/safe_api_call.dart';

@Injectable(as: AddressDatasource)
class AddressDatasourceImpl extends AddressDatasource{
  ApiClient apiClient;
  AddressDatasourceImpl(this.apiClient);
  @override
  Future<ApiResult<AddAddressResponse>?> addAddress(String token,AddressModel addAddressRequest) {
    return safeApiCall<AddAddressResponse>(
      call: () => apiClient.addAddress(token: token, request: addAddressRequest),
    );
  }

}
