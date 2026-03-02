import 'package:equatable/equatable.dart';

sealed class SavedAddressIntent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAddressesIntent extends SavedAddressIntent {}

class DeleteAddressIntent extends SavedAddressIntent {
  final String addressId;

  DeleteAddressIntent({required this.addressId});

  @override
  List<Object?> get props => [addressId];
}

class EditAddressIntent extends SavedAddressIntent {
  final String addressId;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  EditAddressIntent({
    required this.addressId,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  @override
  List<Object?> get props => [
    addressId,
    street,
    phone,
    city,
    lat,
    long,
    username,
  ];
}
