import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_address_response.g.dart';

@JsonSerializable()
class GetAddressResponse {
  @JsonKey(name: "error")
  final String? error;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<Address>? addresses;

  GetAddressResponse({this.error, this.message, this.addresses});

  factory GetAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAddressResponseToJson(this);
  }

  List<AddressEntity> toEntityList() {
    return addresses?.map((e) => e.toEntity()).toList() ?? [];
  }
}
