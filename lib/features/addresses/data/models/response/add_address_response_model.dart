import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';

part 'add_address_response_model.g.dart';

@JsonSerializable()
class AddAddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "address")
  final List<AddressModel>? address;

  AddAddressResponse({this.message, this.address});

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressResponseToJson(this);
}
