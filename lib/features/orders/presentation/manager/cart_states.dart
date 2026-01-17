import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';

class CartStates {
  final Resource<UserCartsModel>? cart;

  CartStates({this.cart});
  CartStates copyWith({Resource<UserCartsModel>? cart}) {
    return CartStates(cart: cart ?? this.cart);
  }
}
