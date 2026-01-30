import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'saved_address_intent.dart';
import 'saved_address_states.dart';

@injectable
class SavedAddressCubit extends Cubit<SavedAddressStates> {
  final AddressRepo _addressRepo;
  final AuthStorage _authStorage;

  SavedAddressCubit(this._addressRepo, this._authStorage)
    : super(SavedAddressStates());

  void doIntent(SavedAddressIntent intent) {
    switch (intent.runtimeType) {
      case GetAddressesIntent:
        _getAddresses();
        break;

      case DeleteAddressIntent:
        _deleteAddress(intent as DeleteAddressIntent);
        break;

      case EditAddressIntent:
        _editAddress(intent as EditAddressIntent);
        break;
    }
  }

  Future<void> _getAddresses() async {
    emit(state.copyWith(addressesResource: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(addressesResource: Resource.error('Token not found')),
      );
      return;
    }

    final result = await _addressRepo.getAddresses(token: 'Bearer $token');

    switch (result) {
      case SuccessApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.success(result.data)));
        break;

      case ErrorApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.error(result.error)));
        break;
    }
  }

  Future<void> _deleteAddress(DeleteAddressIntent intent) async {
    emit(state.copyWith(addressesResource: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(addressesResource: Resource.error('Token not found')),
      );
      return;
    }

    final result = await _addressRepo.deleteAddress(
      token: 'Bearer $token',
      addressId: intent.addressId,
    );

    switch (result) {
      case SuccessApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.success(result.data)));
        break;

      case ErrorApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.error(result.error)));
        break;
    }
  }

  Future<void> _editAddress(EditAddressIntent intent) async {
    emit(state.copyWith(addressesResource: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(addressesResource: Resource.error('Token not found')),
      );
      return;
    }

    final result = await _addressRepo.editAddress(
      token: 'Bearer $token',
      addressId: intent.addressId,
      street: intent.street,
      phone: intent.phone,
      city: intent.city,
      lat: intent.lat,
      long: intent.long,
      username: intent.username,
    );

    switch (result) {
      case SuccessApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.success(result.data)));
        break;

      case ErrorApiResult<List<AddressEntity>>():
        emit(state.copyWith(addressesResource: Resource.error(result.error)));
        break;
    }
  }
}
