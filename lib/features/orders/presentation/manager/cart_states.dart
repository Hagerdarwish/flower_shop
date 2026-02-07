import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';

enum CartAction { none, adding, featching, deleting }

class CartStates {
  final Resource<UserCartsModel>? cart;
  final CartAction lastAction;

  CartStates({this.cart, this.lastAction = CartAction.none});
  CartStates copyWith({
    Resource<UserCartsModel>? cart,
    CartAction? lastAction,
  }) {
    return CartStates(
      cart: cart ?? this.cart,
      lastAction: lastAction ?? this.lastAction,
    );
  }
}
