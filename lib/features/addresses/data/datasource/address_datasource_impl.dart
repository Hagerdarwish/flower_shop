import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/api_manger/api_client.dart';
import '../../../../app/core/network/api_result.dart';
import '../../../../app/core/network/safe_api_call.dart';
import '../models/address_request.dart';
import '../models/address_response.dart';
import '../models/get_address_response.dart';
import '../models/response/add_address_response_model.dart';
import '../models/response/address_model.dart';

@Injectable(as: AddressDatasource)
class AddressDatasourceImpl extends AddressDatasource {
  ApiClient apiClient;
  AddressDatasourceImpl(this.apiClient);
  @override
  Future<ApiResult<GetAddressResponse>?> getAddresses({required String token}) {
    return safeApiCall(call: () => apiClient.getAddresses(token: token));
  }

  @override
  Future<ApiResult<AddressResponse>?> deleteAddress({
    required String token,
    required String addressId,
  }) {
    return safeApiCall(
      call: () => apiClient.deleteAddress(token: token, addressId: addressId),
    );
  }

  @override
  Future<ApiResult<AddAddressResponse>?> addAddress(
    String token,
    AddressModel addAddressRequest,
  ) {
    return safeApiCall<AddAddressResponse>(
      call: () =>
          apiClient.addAddress(token: token, request: addAddressRequest),
    );
  }

  @override
  Future<ApiResult<AddressResponse>?> editAddress({
    required String token,
    required String addressId,
    required AddressModel addressRequest,
  }) {
    return safeApiCall(
      call: () => apiClient.editAddress(
        token: token,
        addressId: addressId,
        request: addressRequest,
      ),
    );
  }
}
