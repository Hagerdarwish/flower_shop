import 'package:flower_shop/features/best_seller/data/fake_data.dart';
import 'package:flower_shop/features/bset_sell/cubit/best_sell_state.dart';
import 'package:flower_shop/features/best_seller/domain/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  final List<ProductModel> products;

  BestSellerCubit(this.products) : super(BestSellerInitial()) {
    loadBestSellers();
  }

  void loadBestSellers() {
    if (products.isEmpty) {
      emit(BestSellerEmpty());
    } else {
      emit(BestSellerLoaded(FakeProducts.products));
    }
  }
}


