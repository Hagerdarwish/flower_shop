import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_orders_usecases.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  final GetOrdersUsecases _getOrdersUsecases;
  final AuthStorage _authStorage;

  OrderCubit(this._getOrdersUsecases, this._authStorage)
    : super(OrderState.initial());

  void doIntent(OrderIntent intent) {
    if (intent is GetOrdersEvent) {
      _getOrders();
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(orders: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null) {
      emit(state.copyWith(orders: Resource.error("Token not found")));
      return;
    }

    final result = await _getOrdersUsecases(token: "Bearer $token");

    switch (result) {
      case SuccessApiResult<OrderResponse> success:
        emit(state.copyWith(orders: Resource.success(success.data)));
      case ErrorApiResult<OrderResponse> failure:
        emit(state.copyWith(orders: Resource.error(failure.error)));
    }
  }
}
