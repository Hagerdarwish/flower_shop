import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

class ProductsSearchStates {
  final Resource<List<ProductModel>>? products;
  ProductsSearchStates({this.products});

  ProductsSearchStates copyWith({Resource<List<ProductModel>>? products}) {
    return ProductsSearchStates(products: products ?? this.products);
  }
}
