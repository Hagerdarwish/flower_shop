import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import '../../../../../../app/config/base_state/base_state.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final GetBestSellerUseCase _getBestSellers;

  BestSellerCubit(this._getBestSellers) : super(BestSellerState.initial());

  void doIntent(BestSellerIntent intent) {
    if (intent is LoadBestSellersEvent) {
      _loadBestSellers();
    }
  }

  Future<void> _loadBestSellers() async {
    // Emit loading state
    emit(state.copyWith(products: Resource.loading()));

    final result = await _getBestSellers();

    switch (result) {
      case SuccessApiResult<List<BestSellerModel>>():
        final products = result.data;
        if (products.isEmpty) {
          emit(state.copyWith(products: Resource.success(products)));
        } else {
          emit(state.copyWith(products: Resource.success(products)));
        }

      case ErrorApiResult<List<BestSellerModel>>():
        emit(state.copyWith(products: Resource.error(result.error.toString())));
    }
  }
}
