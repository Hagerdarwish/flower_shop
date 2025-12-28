import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/categories/domain/usecase/all_categories_usecase.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_intent.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  final AllCategoriesUsecase _allCategoriesUsecase;
  AllCategoriesCubit(this._allCategoriesUsecase) : super(AllCategoriesStates());
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
    emit(state.copyWith(allCategoriesCopyWith: Resource.loading()));
    ApiResult<AllCategoriesModel> response = await _allCategoriesUsecase.call();

    switch (response) {
      case SuccessApiResult<AllCategoriesModel>():
        categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          ...?response.data.categories?.whereType<CategoryItemModel>(),
        ];
        emit(
          state.copyWith(
            allCategoriesCopyWith: Resource.success(response.data),
          ),
        );

      case ErrorApiResult<AllCategoriesModel>():
        emit(
          state.copyWith(allCategoriesCopyWith: Resource.error(response.error)),
        );
    }
  }

  void _selectCategory(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    emit(state.copyWith(allCategoriesCopyWith: state.allCategories));
  }
}
