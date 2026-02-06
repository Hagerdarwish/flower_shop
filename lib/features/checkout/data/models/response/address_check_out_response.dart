import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_check_out_response.g.dart';

double _safeDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}

@JsonSerializable()
class AddressCheckOutResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "addresses")
  final List<Address> addresses;

  AddressCheckOutResponse({required this.message, required this.addresses});

  factory AddressCheckOutResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressCheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressCheckOutResponseToJson(this);

  List<AddressModel> toDomain() {
    return addresses.map((e) => e.toDomain()).toList();
  }
}

@JsonSerializable()
class Address {
  @JsonKey(name: "street")
  final String street;

  @JsonKey(name: "phone")
  final String phone;

  @JsonKey(name: "city")
  final String city;

  @JsonKey(name: "lat")
  final dynamic lat;

  @JsonKey(name: "long")
  final dynamic long;

  @JsonKey(name: "username")
  final String username;

  @JsonKey(name: "_id")
  final String id;

  Address({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  AddressModel toDomain() {
    return AddressModel(
      id: id,
      username: username,
      phone: phone,
      city: city,
      street: street,
      lat: _safeDouble(lat),
      long: _safeDouble(long),
    );
  }
}
