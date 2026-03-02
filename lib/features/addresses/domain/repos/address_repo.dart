import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

import '../../data/models/response/address_model.dart';
import '../models/address_dto.dart';

abstract class AddressRepo {
  Future<ApiResult<List<AddressEntity>>> getAddresses({required String token});
  Future<ApiResult<List<AddressEntity>>> deleteAddress({
    required String token,
    required String addressId,
  });
  Future<ApiResult<AddressDto>?> addAddress(
    String token,
    AddressModel addAddressRequest,
  );

  Future<ApiResult<List<AddressEntity>>> editAddress({
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
