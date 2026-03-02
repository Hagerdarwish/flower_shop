import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "error")
  final String? error;
  @JsonKey(name: "address")
  final List<Address>? address;

  AddressResponse({this.message, this.error, this.address});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return _$AddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressResponseToJson(this);
  }

  List<AddressEntity> toEntityList() {
    return address?.map((e) => e.toEntity()).toList() ?? [];
  }
}
