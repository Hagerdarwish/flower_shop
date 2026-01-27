import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_addresses_response.g.dart';

@JsonSerializable()
class GetAddressesResponse {
  @JsonKey(name: "error")
  final String? error;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<Address>? addresses;

  GetAddressesResponse({this.error, this.message, this.addresses});

  factory GetAddressesResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAddressesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAddressesResponseToJson(this);
  }
}
