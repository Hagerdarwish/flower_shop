import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';

class OrderState {
  final Resource<OrderResponse> orders;

  OrderState({required this.orders});

  factory OrderState.initial() {
    return OrderState(orders: Resource.initial());
  }

  OrderState copyWith({Resource<OrderResponse>? orders}) {
    return OrderState(orders: orders ?? this.orders);
  }
}
