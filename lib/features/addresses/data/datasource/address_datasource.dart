import '../../../../app/core/network/api_result.dart';
import '../models/response/add_address_response_model.dart';
import '../models/response/address_model.dart';

abstract class AddressDatasource{
  Future<ApiResult<AddAddressResponse>?> addAddress(String token,AddressModel addAddressRequest);

}