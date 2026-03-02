import 'package:json_annotation/json_annotation.dart';
part 'paymentRequest.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentRequest {
  @JsonKey(name: "shippingAddress")
  ShippingAddress? shippingAddress;

  PaymentRequest({this.shippingAddress});

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRequestToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "long")
  String? long;

  ShippingAddress({this.street, this.phone, this.city, this.lat, this.long});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}
