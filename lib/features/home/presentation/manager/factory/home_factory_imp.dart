import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_occasions_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_products_usecase.dart';
import 'package:flower_shop/features/home/presentation/manager/factory/home_factory.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeFactory)
class RemoteHomeFactory implements HomeFactory {
  final GetProductsUseCase _products;
  final GetCategoriesUseCase _categories;
  final GetBestSellerUseCase _bestSeller;
  final GetOccasionsUseCase _occasions;

  RemoteHomeFactory(
    this._products,
    this._categories,
    this._bestSeller,
    this._occasions,
  );

  @override
  GetProductsUseCase products() => _products;

  @override
  GetCategoriesUseCase categories() => _categories;

  @override
  GetBestSellerUseCase bestSeller() => _bestSeller;

  @override
  GetOccasionsUseCase occasions() => _occasions;
}
