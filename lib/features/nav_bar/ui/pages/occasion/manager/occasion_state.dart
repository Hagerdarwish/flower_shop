
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';
import '../../../../../../app/config/base_state/base_state.dart';

class OccasionState {
  final Resource<List<ProductModel>> products;
  final String selectedItem;

  const OccasionState({
    required this.products,
    required this.selectedItem ,
  });

  factory OccasionState.initial() => OccasionState(
    products: Resource.initial(),
    selectedItem: '',
  );

  OccasionState copyWith({
    Resource<List<ProductModel>>? products,
    String? selectedItem,
  }) {
    return OccasionState(
      products: products ?? this.products,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
