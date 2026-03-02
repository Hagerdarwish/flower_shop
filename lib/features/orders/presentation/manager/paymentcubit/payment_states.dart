import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';

enum PaymentAction { none, executing }

class PaymentStates {
  final Resource<PaymentResponse>? paymentResponse;
  final PaymentAction lastAction;

  PaymentStates({this.paymentResponse, this.lastAction = PaymentAction.none});

  PaymentStates copyWith({
    Resource<PaymentResponse>? paymentResponse,
    PaymentAction? lastAction,
  }) {
    return PaymentStates(
      paymentResponse: paymentResponse ?? this.paymentResponse,
      lastAction: lastAction ?? this.lastAction,
    );
  }
}
