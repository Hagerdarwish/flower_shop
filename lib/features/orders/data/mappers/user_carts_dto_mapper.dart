import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';

extension UserCartsDtoMapper on UserCartsDto {
  UserCartsModel toUserCartsModel() {
    return UserCartsModel(
      message: message,
      error: error,
      numOfCartItems: numOfCartItems,
      cart: cart?.toCartModel(),
    );
  }
}

extension CartModelMapper on CartDto {
  CartModel toCartModel() {
    return CartModel(
      id: id,
      user: user,
      totalPrice: totalPrice,
      appliedCoupons: appliedCoupons,
      cartItems: cartItems?.map((e) => e?.toCartItemModel()).toList(),
    );
  }
}

extension CartItemModelMapper on CartItemsDto {
  CartItemsModel toCartItemModel() {
    return CartItemsModel(
      id: id,
      price: price,
      product: product?.toProductCartModel(),
      quantity: quantity,
    );
  }
}

extension ProductCartModelMapper on ProductCartDto {
  ProductCartModel toProductCartModel() {
    return ProductCartModel(
      id: id,
      price: price,
      description: description,
      title: title,
      imgCover: imgCover,
      quantity: quantity,
      priceAfterDiscount: priceAfterDiscount,
    );
  }
}
