import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../app/config/base_state/base_state.dart';
import '../../../../../../app/core/network/api_result.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/usecase/get_product_usecase.dart';
import 'occasion_event.dart';
import 'occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetProductUsecase _getProductUsecase;

  OccasionCubit(  this._getProductUsecase) : super(OccasionState.initial());

  void doIntent(OccasionEvents event) {
    switch (event) {
      case LoadInitialEvent():
        _loadInitial(initialOccasion: event.initialOccasion);
      case TabChangedEvent():
        _onTabChanged(event.tab);
    }
  }

  Future<void> _loadInitial({String? initialOccasion}) async {
    await _getProducts(occasion: initialOccasion);
  }

  Future<void> _getProducts({String? occasion}) async {
    emit(
      state.copyWith(
        selectedItem: occasion ?? state.selectedItem,
        products: Resource.loading(),
      ),
    );
    try {
      final ApiResult<List<ProductModel>> result = await _getProductUsecase
          .call(occasion: occasion);
      switch (result) {
        case SuccessApiResult<List<ProductModel>>():
          emit(state.copyWith(products: Resource.success(result.data)));
        case ErrorApiResult<List<ProductModel>>():
          emit(state.copyWith(products: Resource.error(result.error)));
      }
    } catch (e) {
      emit(
        state.copyWith(
          products: Resource.error(AppConstants.defaultErrorMessage),
        ),
      );
    }
  }

  Future<void> _onTabChanged(String tab) async {
    if (tab == state.selectedItem) return;

    emit(state.copyWith(selectedItem: tab, products: Resource.loading()));

    final result = await _getProductUsecase.call(occasion: tab);

    switch (result) {
      case SuccessApiResult<List<ProductModel>>(:final data):
        emit(state.copyWith(products: Resource.success(data)));

      case ErrorApiResult<List<ProductModel>>(:final error):
        emit(state.copyWith(products: Resource.error(error)));
    }
  }
}
