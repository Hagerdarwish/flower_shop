import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

class SavedAddressStates {
  final Resource<List<AddressEntity>> addressesResource;

  SavedAddressStates({Resource<List<AddressEntity>>? addressesResource})
    : addressesResource = addressesResource ?? Resource.initial();

  SavedAddressStates copyWith({
    Resource<List<AddressEntity>>? addressesResource,
  }) {
    return SavedAddressStates(
      addressesResource: addressesResource ?? this.addressesResource,
    );
  }
}
