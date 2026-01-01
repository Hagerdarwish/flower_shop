import 'package:flower_shop/features/best_seller/domain/product_model.dart';

abstract class BestSellerState {}

class BestSellerInitial extends BestSellerState {}

class BestSellerLoaded extends BestSellerState {
  final List<ProductModel> products;
  BestSellerLoaded(this.products);
}

class BestSellerEmpty extends BestSellerState {}
