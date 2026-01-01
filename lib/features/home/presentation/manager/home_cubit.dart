import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/features/home/presentation/manager/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/presentation/manager/factory/home_factory.dart';
import 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeFactory _factory;

  HomeCubit(this._factory) : super(HomeState());

  void doIntent(HomeIntent intent) {
    switch (intent.runtimeType) {
      case LoadHomeData:
        _loadHome();
        break;
    }
  }

  Future<void> _loadHome() async {
    emit(
      state.copyWith(
        categories: Resource.loading(),
        bestSeller: Resource.loading(),
        occasions: Resource.loading(),
      ),
    );
    await Future.wait([
      _loadProducts(),
      _loadCategories(),
      _loadBestSeller(),
      _loadOccasions(),
    ]);
  }

  Future<void> _loadProducts() async {
    final result = await _factory.products().call();
    switch (result) {
      case SuccessApiResult<List<ProductModel>>():
        emit(state.copyWith(products: Resource.success(result.data)));
        break;
      case ErrorApiResult<List<ProductModel>>():
        emit(state.copyWith(products: Resource.error(result.error)));
        break;
    }
  }

  Future<void> _loadCategories() async {
    final result = await _factory.categories().call();
    switch (result) {
      case SuccessApiResult<List<CategoryModel>>():
        emit(state.copyWith(categories: Resource.success(result.data)));
        break;
      case ErrorApiResult<List<CategoryModel>>():
        emit(state.copyWith(categories: Resource.error(result.error)));
        break;
    }
  }

  Future<void> _loadBestSeller() async {
    final result = await _factory.bestSeller().call();
    switch (result) {
      case SuccessApiResult<List<BestSellerModel>>():
        emit(state.copyWith(bestSeller: Resource.success(result.data)));
        break;
      case ErrorApiResult<List<BestSellerModel>>():
        emit(state.copyWith(bestSeller: Resource.error(result.error)));
        break;
    }
  }

  Future<void> _loadOccasions() async {
    final result = await _factory.occasions().call();
    switch (result) {
      case SuccessApiResult<List<OccasionModel>>():
        emit(state.copyWith(occasions: Resource.success(result.data)));
        break;
      case ErrorApiResult<List<OccasionModel>>():
        emit(state.copyWith(occasions: Resource.error(result.error)));
        break;
    }
  }
}
