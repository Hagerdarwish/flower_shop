import 'package:flower_shop/features/home/domain/models/product_model.dart';

class UserCartsModel {
  final String? message;
  final String? error;
  final int? numOfCartItems;
  final CartModel? cart;

  UserCartsModel({this.message, this.error, this.numOfCartItems, this.cart});
}

class CartModel {
  final String? id;
  final String? user;
  final List<CartItemsModel?>? cartItems;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  CartModel({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}

class CartItemsModel {
  final ProductModel? product;
  final int? price;
  final int? quantity;
  final String? id;

  CartItemsModel({this.product, this.price, this.quantity, this.id});
}
