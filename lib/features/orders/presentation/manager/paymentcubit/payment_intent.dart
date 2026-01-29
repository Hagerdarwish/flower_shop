sealed class PaymentIntent {}

class ExecutePaymentIntent extends PaymentIntent {
  final String token;
  final String returnUrl;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;

  ExecutePaymentIntent({
    required this.token,
    required this.returnUrl,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });
}
