import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/usecase/get_user_carts_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartCubit extends Cubit<CartStates> {
  final GetUserCartsUsecase _getCarts;
  CartCubit(this._getCarts) : super(CartStates());

  List<CartItemsModel> cartsList = [];

  void doIntent(CartIntent intent) {
    switch (intent) {
      case GetAllCartsIntent():
        _getAllCarts();
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
}
