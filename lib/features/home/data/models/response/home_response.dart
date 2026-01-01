import 'package:flower_shop/features/home/data/models/best_seller_model.dart';
import 'package:flower_shop/features/home/data/models/category_model.dart';
import 'package:flower_shop/features/home/data/models/occasion_model.dart';
import 'package:flower_shop/features/home/data/models/product_model.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<Product>? products;
  @JsonKey(name: "categories")
  final List<Category>? categories;
  @JsonKey(name: "bestSeller")
  final List<BestSeller>? bestSeller;
  @JsonKey(name: "occasions")
  final List<Occasion>? occasions;

  HomeResponse({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeResponseToJson(this);
  }

    HomeModel toEntity() {
    return HomeModel(
      message: message ?? '',
      products: products?.map((e) => e.toEntity()).toList() ?? [],
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      bestSeller: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
