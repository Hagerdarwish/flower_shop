import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/commerce/domain/usecase/all_categories_usecase.dart';
import 'package:flower_shop/features/commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/commerce/presentation/categories/manager/all_categories_states.dart';
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';
import 'package:flower_shop/features/nav_bar/domain/usecase/get_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  final AllCategoriesUsecase _allCategoriesUsecase;
  final GetProductUsecase _getProductUsecase;
  AllCategoriesCubit(this._allCategoriesUsecase, this._getProductUsecase)
    : super(AllCategoriesStates());
  List<CategoryItemModel> categoriesList = [];
  int selectedIndex = 0;

  void doIntent(AllCategoriesIntent intent) {
    switch (intent) {
      case GetAllCategoriesEvent():
        _getAllCategories();
      case SelectCategoryEvent():
        _selectCategory(intent.selectedIndex);
    }
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(allCategories: Resource.loading()));
    ApiResult<AllCategoriesModel> response = await _allCategoriesUsecase.call();
    switch (response) {
      case SuccessApiResult<AllCategoriesModel>():
        categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          ...?response.data.categories?.whereType<CategoryItemModel>(),
        ];
        emit(
          state.copyWith(
            allCategories: Resource.success(response.data),
          ),
        );
        _getProducts(category: null);

      case ErrorApiResult<AllCategoriesModel>():
        emit(
          state.copyWith(allCategories: Resource.error(response.error)),
        );
    }
  }

  void _selectCategory(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    final selectedCategory = categoriesList[index];
    if (selectedCategory.id == '0') {
      _getProducts(category: null);
    } else {
      _getProducts(category: selectedCategory.id);
    }
    emit(state.copyWith(allCategories: state.allCategories));
  }

  Future<void> _getProducts({String? category}) async {
    emit(state.copyWith(products: Resource.loading()));
    final ApiResult<List<ProductModel>> result = await _getProductUsecase.call(
      category: category,
    );
    switch (result) {
      case SuccessApiResult<List<ProductModel>>():
        final newList = List<ProductModel>.from(result.data);
        emit(state.copyWith(products: Resource.success(newList)));
      case ErrorApiResult<List<ProductModel>>():
        emit(state.copyWith(products: Resource.error(result.error)));
    }
  }
}
