import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';

import '../../../../e_commerce/domain/models/product_model.dart';

class AllCategoriesStates {
  final Resource<AllCategoriesModel>? allCategories;
  final Resource<List<ProductModel>>? products;

  AllCategoriesStates({this.allCategories, this.products});
  AllCategoriesStates copyWith({
    Resource<AllCategoriesModel>? allCategories,
    Resource<List<ProductModel>>? products,
  }) {
    return AllCategoriesStates(
      allCategories: allCategories ?? this.allCategories,
      products: products ?? this.products,
    );
  }
}
