import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_occasions_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_products_usecase.dart';

abstract class HomeFactory {
  GetProductsUseCase products();
  GetCategoriesUseCase categories();
  GetBestSellerUseCase bestSeller();
  GetOccasionsUseCase occasions();
}
