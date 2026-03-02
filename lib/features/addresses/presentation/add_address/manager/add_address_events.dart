import '../../../domain/models/city_item.dart';
import '../../../domain/models/area_item.dart';

sealed class AddAddressEvent {}

class LoadLookupsEvent extends AddAddressEvent {}

class AddressChangedEvent extends AddAddressEvent {
  final String address;
  AddressChangedEvent(this.address);
}

class PhoneChangedEvent extends AddAddressEvent {
  final String phone;
  PhoneChangedEvent(this.phone);
}

class RecipientChangedEvent extends AddAddressEvent {
  final String recipient;
  RecipientChangedEvent(this.recipient);
}

class SubmitAddAddressEvent extends AddAddressEvent {
  final String token;
  SubmitAddAddressEvent(this.token);
}

class AreaSelectedEvent extends AddAddressEvent {
  final AreaItem area;
  AreaSelectedEvent(this.area);
}

class CitySelectedEvent extends AddAddressEvent {
  final CityItem city;
  CitySelectedEvent(this.city);
}

class LocationPickedEvent extends AddAddressEvent {
  final double lat;
  final double lng;
  LocationPickedEvent({required this.lat, required this.lng});
}
