import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDatasource)
class AddressDatasourceImpl extends AddressDatasource {
  ApiClient apiClient;
  AddressDatasourceImpl(this.apiClient);
  @override
  Future<ApiResult<AddressResponse>?> getAddresses({required String token}) {
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
  Future<ApiResult<AddressResponse>?> editAddress({
    required String token,
    required String addressId,
    required AddressRequest addressRequest,
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
