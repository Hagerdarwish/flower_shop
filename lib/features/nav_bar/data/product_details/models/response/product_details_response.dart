import 'package:json_annotation/json_annotation.dart';

import 'product_details_model.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse {
  final String message;
  final ProductDetailsModel product;

  ProductDetailsResponse({
    required this.message,
    required this.product,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductDetailsResponseToJson(this);
}
