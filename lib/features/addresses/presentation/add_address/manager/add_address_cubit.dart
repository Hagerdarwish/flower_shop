import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';

import '../../../../../app/core/utils/validators_helper.dart';
import '../../../domain/models/city_item.dart';
import '../../../domain/models/area_item.dart';
import '../../../domain/usecase/add_address_usecase.dart';
import 'add_address_events.dart';
import 'add_address_state.dart';

@injectable
class AddAddressCubit extends Cubit<AddAddressState> {
  final AddAddressUsecase _addAddressUsecase;

  AddAddressCubit(this._addAddressUsecase) : super(AddAddressState.initial());

  void doIntent(AddAddressEvent event) {
    switch (event) {
      case AddressChangedEvent():
        _onAddressChanged(event.address);
        break;
      case PhoneChangedEvent():
        _onPhoneChanged(event.phone);
        break;
      case RecipientChangedEvent():
        _onRecipientChanged(event.recipient);
        break;
      case SubmitAddAddressEvent():
        _submit(token: event.token);
        break;
      case AreaSelectedEvent():
        final next = state.copyWith(selectedArea: event.area);
        emit(next.copyWith(isFormValid: _validate(next)));
        break;
      case CitySelectedEvent():
        final governorate = event.city;
        final filteredAreas = state.allAreas
            .where((a) => a.governorateId == governorate.id)
            .toList();

        final next = state.copyWith(
          selectedCity: governorate,
          selectedArea: null,
          area: filteredAreas,
        );
        emit(next.copyWith(isFormValid: _validate(next)));
        break;
      case LoadLookupsEvent():
        _loadLookups();
        break;
      case LocationPickedEvent():
        final next = state.copyWith(lat: event.lat, lng: event.lng);
        emit(next.copyWith(isFormValid: _validate(next)));
        break;
    }
  }

  Future<void> _loadLookups() async {
    // load areas
    final areaStr = await rootBundle.loadString('assets/data/states.json');
    final List areaJson = jsonDecode(areaStr) as List;
    final areaObj = areaJson.cast<Map<String, dynamic>>().firstWhere(
      (x) => x['type'] == 'table' && x['name'] == 'cities',
      orElse: () => {},
    );
    final List dataArea = (areaObj['data'] as List? ?? []);
    final areas = dataArea
        .map((e) => AreaItem.fromJson(e as Map<String, dynamic>))
        .toList();

    // loaf Cities
    final citiesStr = await rootBundle.loadString('assets/data/cities.json');
    final List root = jsonDecode(citiesStr) as List;
    final tableObj = root.cast<Map<String, dynamic>>().firstWhere(
      (x) => x['type'] == 'table' && x['name'] == 'governorates',
      orElse: () => {},
    );

    final List data = (tableObj['data'] as List? ?? []);
    final cities = data
        .map((e) => CityItem.fromJson(e as Map<String, dynamic>))
        .toList();

    final next = state.copyWith(area: areas, cities: cities, allAreas: areas);
    emit(next.copyWith(isFormValid: _validate(next)));
  }

  void _onAddressChanged(String v) {
    final next = state.copyWith(address: v);
    emit(next.copyWith(isFormValid: _validate(next)));
  }

  void _onPhoneChanged(String v) {
    final next = state.copyWith(phone: v);
    emit(next.copyWith(isFormValid: _validate(next)));
  }

  void _onRecipientChanged(String v) {
    final next = state.copyWith(recipient: v);
    emit(next.copyWith(isFormValid: _validate(next)));
  }

  bool _validate(AddAddressState s) {
    final addressOk = Validators.validateAddress(s.address) == null;
    final phoneOk = Validators.validatePhone(s.phone) == null;
    final countryOk = s.selectedArea != null;
    final cityOk = s.selectedCity != null;
    final recipientOk = Validators.validateRecipientName(s.recipient) == null;
    return addressOk && phoneOk && recipientOk && countryOk && cityOk;
  }

  Future<void> _submit({required String token}) async {
    if (!state.isFormValid) return;
    if (state.submitResult.status == Status.loading) return;

    emit(state.copyWith(submitResult: Resource.loading()));

    final request = AddressModel(
      street: state.address,
      phone: state.phone,
      username: state.recipient,
      city: state.selectedCity?.nameEn,
      lat: state.lat?.toString(),
      long: state.lng?.toString(),
    );

    final result = await _addAddressUsecase(token: token, data: request);

    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(submitResult: Resource.success(result!.data)));
        break;
      case ErrorApiResult():
        emit(state.copyWith(submitResult: Resource.error(result!.error)));
        break;
      case null:
        emit(
          state.copyWith(submitResult: Resource.error("Something went wrong")),
        );
        break;
    }
  }
}
