import '../../../../checkout/domain/models/cash_order_model.dart';

abstract class PaymentIntent {}

class ExecutePaymentIntent extends PaymentIntent {
  String? token;
  final String returnUrl;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final CashOrderModel? order;

  ExecutePaymentIntent({
    this.token,
    required this.returnUrl,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.order,
  });
}

class SimulatePaymentSuccessIntent extends PaymentIntent {}
