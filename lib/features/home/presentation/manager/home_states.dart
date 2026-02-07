import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

class HomeState {
  final Resource<List<ProductModel>> products;
  final Resource<List<CategoryModel>> categories;
  final Resource<List<BestSellerModel>> bestSeller;
  final Resource<List<OccasionModel>> occasions;

  HomeState({
    Resource<List<ProductModel>>? products,
    Resource<List<CategoryModel>>? categories,
    Resource<List<BestSellerModel>>? bestSeller,
    Resource<List<OccasionModel>>? occasions,
  }) : products = products ?? Resource.initial(),
       categories = categories ?? Resource.initial(),
       bestSeller = bestSeller ?? Resource.initial(),
       occasions = occasions ?? Resource.initial();

  HomeState copyWith({
    Resource<List<ProductModel>>? products,
    Resource<List<CategoryModel>>? categories,
    Resource<List<BestSellerModel>>? bestSeller,
    Resource<List<OccasionModel>>? occasions,
  }) {
    return HomeState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      bestSeller: bestSeller ?? this.bestSeller,
      occasions: occasions ?? this.occasions,
    );
  }
}
