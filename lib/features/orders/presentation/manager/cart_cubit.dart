import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/usecase/add_product_to_cart_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/delete_cart_item_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/get_user_carts_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/update_cart_item_quantity_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartCubit extends Cubit<CartStates> {
  final GetUserCartsUsecase _getCarts;
  final AddProductToCartUsecase _addProductToCartUsecase;
  final DeleteCartItemUsecase _deleteCartItemUsecase;
  final UpdateCartItemQuantityUsecase _updateCartItemQuantityUsecase;
  CartCubit(
    this._getCarts,
    this._addProductToCartUsecase,
    this._deleteCartItemUsecase,
    this._updateCartItemQuantityUsecase,
  ) : super(CartStates());

  List<CartItemsModel> cartsList = [];

  void doIntent(CartIntent intent) {
    switch (intent) {
      case GetAllCartsIntent():
        _getAllCarts();
      case AddProductToCartIntent():
        _addProductToCart(product: intent.productId, quantity: intent.quantity);
      case DeleteCartItemIntent():
        _deleteCartItem(cartItemId: intent.cartItemId);
      case UpdateCartItemQuantityIntent():
        _updateCartItemQuantity(
          cartItemId: intent.cartItemId,
          quantity: intent.quantity,
          increase: intent.increase,
        );
    }
  }

  Future<void> _getAllCarts() async {
    emit(state.copyWith(cart: Resource.loading()));
    ApiResult<UserCartsModel> response = await _getCarts.call();
    switch (response) {
      case SuccessApiResult<UserCartsModel>():
        cartsList =
            response.data.cart?.cartItems
                ?.whereType<CartItemsModel>()
                .toList() ??
            [];
        emit(state.copyWith(cart: Resource.success(response.data)));

      case ErrorApiResult<UserCartsModel>():
        emit(state.copyWith(cart: Resource.error(response.error)));
    }
  }

  Future<void> _addProductToCart({
    required String product,
    required int quantity,
  }) async {
    emit(
      state.copyWith(cart: Resource.loading(), lastAction: CartAction.adding),
    );
    ApiResult<UserCartsModel> response = await _addProductToCartUsecase.call(
      product: product,
      quantity: quantity,
    );
    switch (response) {
      case SuccessApiResult<UserCartsModel>():
        cartsList =
            response.data.cart?.cartItems
                ?.whereType<CartItemsModel>()
                .toList() ??
            [];
        emit(
          state.copyWith(
            cart: Resource.success(response.data),
            lastAction: CartAction.adding,
          ),
        );

      case ErrorApiResult<UserCartsModel>():
        emit(state.copyWith(cart: Resource.error(response.error)));
    }
  }

  Future<void> _deleteCartItem({required String cartItemId}) async {
    emit(state.copyWith(cart: Resource.loading()));
    ApiResult<UserCartsModel> response = await _deleteCartItemUsecase.call(
      cartItemId: cartItemId,
    );
    switch (response) {
      case SuccessApiResult<UserCartsModel>():
        cartsList.removeWhere((item) => item.id.toString() == cartItemId);

        final updatedCartItems =
            response.data.cart?.cartItems
                ?.whereType<CartItemsModel>()
                .toList() ??
            [];

        cartsList = updatedCartItems;
        emit(state.copyWith(cart: Resource.success(response.data)));

      case ErrorApiResult<UserCartsModel>():
        emit(state.copyWith(cart: Resource.error(response.error)));
    }
  }

  Future<void> _updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
    required bool increase,
  }) async {
    if (!increase && quantity == 1) {
      await _deleteCartItem(cartItemId: cartItemId);
      return;
    }
    final newQuantity = increase ? quantity + 1 : quantity - 1;
    emit(state.copyWith(cart: Resource.loading()));
    ApiResult<UserCartsModel> response = await _updateCartItemQuantityUsecase
        .call(cartItemId: cartItemId, quantity: newQuantity);

    switch (response) {
      case SuccessApiResult<UserCartsModel>():
        cartsList =
            response.data.cart?.cartItems
                ?.whereType<CartItemsModel>()
                .toList() ??
            [];
        emit(state.copyWith(cart: Resource.success(response.data)));

      case ErrorApiResult<UserCartsModel>():
        emit(state.copyWith(cart: Resource.error(response.error)));
    }
  }

  double get totalPriceAfterDiscount {
    double total = 0;
    for (final item in cartsList) {
      final product = item.product;
      if (product == null) continue;
      final price =
          (product.priceAfterDiscount != null &&
              product.priceAfterDiscount! > 0)
          ? product.priceAfterDiscount!
          : product.price ?? 0;
      total += price * (item.quantity ?? 1);
    }
    return total;
  }

  void resetAction() {
    emit(state.copyWith(lastAction: CartAction.none));
  }
}
