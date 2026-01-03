import 'package:flower_shop/features/e_commerce/data/models/response/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';
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
