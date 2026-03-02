import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';

extension AddressMapper on AddAddressResponse {
  AddressDto toAddress() {
    return AddressDto(message: message);
  }
}
