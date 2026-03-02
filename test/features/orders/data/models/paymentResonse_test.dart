import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';

void main() {
  group('PaymentResponse Model', () {
    final jsonString = '''
    {
      "message": "Payment session created",
      "session": {
        "id": "sess_123",
        "object": "checkout.session",
        "amount_subtotal": 1000,
        "amount_total": 1200,
        "currency": "usd",
        "payment_status": "unpaid",
        "payment_method_types": ["card"],
        "customer_email": "test@example.com",
        "success_url": "https://example.com/success",
        "cancel_url": "https://example.com/cancel"
      }
    }
    ''';

    test('should deserialize JSON to PaymentResponse', () {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final paymentResponse = PaymentResponse.fromJson(jsonMap);

      expect(paymentResponse, isA<PaymentResponse>());
      expect(paymentResponse.message, "Payment session created");

      final session = paymentResponse.session!;
      expect(session.id, "sess_123");
      expect(session.amountSubtotal, 1000);
      expect(session.amountTotal, 1200);
      expect(session.currency, "usd");
      expect(session.paymentStatus, "unpaid");
      expect(session.paymentMethodTypes, ["card"]);
      expect(session.customerEmail, "test@example.com");
      expect(session.successUrl, "https://example.com/success");
      expect(session.cancelUrl, "https://example.com/cancel");
    });

    test('should serialize PaymentResponse to JSON', () {
      final session = Session(
        id: "sess_123",
        object: "checkout.session",
        amountSubtotal: 1000,
        amountTotal: 1200,
        currency: "usd",
        paymentStatus: "unpaid",
        paymentMethodTypes: ["card"],
        customerEmail: "test@example.com",
        successUrl: "https://example.com/success",
        cancelUrl: "https://example.com/cancel",
      );

      final paymentResponse = PaymentResponse(
        message: "Payment session created",
        session: session,
      );

      final jsonMap = paymentResponse.toJson();
      final sessionJson = paymentResponse.session!.toJson();

      expect(jsonMap['message'], "Payment session created");

      expect(sessionJson['id'], "sess_123");
      expect(sessionJson['amount_subtotal'], 1000);
      expect(sessionJson['amount_total'], 1200);
      expect(sessionJson['currency'], "usd");
      expect(sessionJson['payment_status'], "unpaid");
      expect(sessionJson['payment_method_types'], ["card"]);
      expect(sessionJson['customer_email'], "test@example.com");
      expect(sessionJson['success_url'], "https://example.com/success");
      expect(sessionJson['cancel_url'], "https://example.com/cancel");
    });
  });
}
