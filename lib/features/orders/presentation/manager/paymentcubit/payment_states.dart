import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import '../../../../checkout/domain/models/cash_order_model.dart';

enum PaymentAction { none, executing }

class PaymentStates {
  final Resource<PaymentResponse>? paymentResponse;
  final PaymentAction lastAction;
  final CashOrderModel? order;

  PaymentStates({
    this.paymentResponse,
    this.lastAction = PaymentAction.none,
    this.order,
  });

  PaymentStates copyWith({
    Resource<PaymentResponse>? paymentResponse,
    PaymentAction? lastAction,
    CashOrderModel? order,
  }) {
    return PaymentStates(
      paymentResponse: paymentResponse ?? this.paymentResponse,
      lastAction: lastAction ?? this.lastAction,
      order: order ?? this.order,
    );
  }
}
