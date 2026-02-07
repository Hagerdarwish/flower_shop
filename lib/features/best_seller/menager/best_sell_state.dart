import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';

import '../../../../../../app/config/base_state/base_state.dart';

class BestSellerState {
  final Resource<List<BestSellerModel>> products;
  final int selectedIndex; // optional: if you want to track selected item

  const BestSellerState({required this.products, this.selectedIndex = 0});

  factory BestSellerState.initial() =>
      BestSellerState(products: Resource.initial(), selectedIndex: 0);

  BestSellerState copyWith({
    Resource<List<BestSellerModel>>? products,
    int? selectedIndex,
  }) {
    return BestSellerState(
      products: products ?? this.products,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
