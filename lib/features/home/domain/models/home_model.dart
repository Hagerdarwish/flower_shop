import 'package:equatable/equatable.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

class HomeModel extends Equatable {
  final String? message;
  final List<ProductModel>? products;
  final List<CategoryModel>? categories;
  final List<BestSellerModel>? bestSeller;
  final List<OccasionModel>? occasions;

  const HomeModel({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [
        message,
        products,
        categories,
        bestSeller,
        occasions,
      ];
}
