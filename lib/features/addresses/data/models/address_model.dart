import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "_id")
  final String? id;

  Address({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressToJson(this);
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
