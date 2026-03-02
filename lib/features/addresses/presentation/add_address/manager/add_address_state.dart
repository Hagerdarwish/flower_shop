import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';

import '../../../domain/models/city_item.dart';
import '../../../domain/models/area_item.dart';

class AddAddressState {
  final String address;
  final String phone;
  final String recipient;
  final bool isFormValid;
  final List<AreaItem> allAreas;
  final List<AreaItem> area;
  final List<CityItem> cities;
  final AreaItem? selectedArea;
  final CityItem? selectedCity;
  final Resource<AddressDto> submitResult;
  final double? lat;
  final double? lng;

  const AddAddressState({
    required this.address,
    required this.phone,
    required this.recipient,
    required this.isFormValid,
    required this.submitResult,
    required this.cities,
    required this.allAreas,
    required this.area,
    required this.selectedCity,
    required this.selectedArea,
    required this.lat,
    required this.lng,
  });

  factory AddAddressState.initial() => AddAddressState(
    address: '',
    phone: '',
    recipient: '',
    isFormValid: false,
    submitResult: Resource.initial(),
    cities: [],
    area: [],
    selectedCity: null,
    selectedArea: null,
    lat: null,
    lng: null,
    allAreas: [],
  );

  AddAddressState copyWith({
    String? address,
    String? phone,
    String? recipient,
    bool? isFormValid,
    List<AreaItem>? area,
    List<CityItem>? cities,
    AreaItem? selectedArea,
    CityItem? selectedCity,
    List<AreaItem>? allAreas,
    Resource<AddressDto>? submitResult,
    double? lat,
    double? lng,
  }) {
    return AddAddressState(
      address: address ?? this.address,
      phone: phone ?? this.phone,
      recipient: recipient ?? this.recipient,
      isFormValid: isFormValid ?? this.isFormValid,
      submitResult: submitResult ?? this.submitResult,
      cities: cities ?? this.cities,
      area: area ?? this.area,
      allAreas: allAreas ?? this.allAreas,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedArea: selectedArea ?? this.selectedArea,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
