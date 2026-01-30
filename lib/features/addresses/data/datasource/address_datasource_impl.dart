import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:injectable/injectable.dart';

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
  Future<ApiResult<AddAddressResponse>?> addAddress(String token,AddressModel addAddressRequest) {
    return safeApiCall<AddAddressResponse>(
      call: () => apiClient.addAddress(token: token, request: addAddressRequest),
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
