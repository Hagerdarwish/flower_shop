import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/get_product_usecase.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_states.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsSearchCubit extends Cubit<ProductsSearchStates> {
  final GetProductUsecase _searchUsecase;
  ProductsSearchCubit(this._searchUsecase) : super(ProductsSearchStates());

  void doIntent(ProductsSearchIntent intent) {
    switch (intent) {
      case GetProductsByIdIntent():
        _productsSearch(search: intent.search);
    }
  }

  Future<void> _productsSearch({String? search}) async {
    emit(state.copyWith(products: Resource.loading()));
    final ApiResult<List<ProductModel>> result = await _searchUsecase.call(
      search: search,
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
