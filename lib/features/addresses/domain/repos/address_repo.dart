import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';

import '../../../../app/core/network/api_result.dart';
import '../../data/models/response/address_model.dart';

abstract class AddressRepo{
  Future<ApiResult<AddressDto>?> addAddress(String token,AddressModel addAddressRequest);

}