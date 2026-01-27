import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';

abstract class AddressRepo {
  Future<ApiResult<AddressResponse>> getAddresses({required String token});
  Future<ApiResult<AddressResponse>> deleteAddress({
    required String token,
    required String addressId,
  });
  Future<ApiResult<AddressResponse>> editAddress({
    required String token,
    required String addressId,
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  });
}
