import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

class HomeModel {
  final String? message;
  final List<ProductModel>? products;
  final List<CategoryModel>? categories;
  final List<BestSellerModel>? bestSeller;
  final List<OccasionModel>? occasions;

  HomeModel ({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });
}