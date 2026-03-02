import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';

import '../models/response/add_address_response_model.dart';
import '../models/response/address_model.dart';

abstract class AddressDatasource {
  Future<ApiResult<GetAddressResponse>?> getAddresses({required String token});
  Future<ApiResult<AddAddressResponse>?> addAddress(
    String token,
    AddressModel addAddressRequest,
  );

  Future<ApiResult<AddressResponse>?> deleteAddress({
    required String token,
    required String addressId,
  });

  Future<ApiResult<AddressResponse>?> editAddress({
    required String token,
    required String addressId,
    required AddressModel addressRequest,
  });
}
