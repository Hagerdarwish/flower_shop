import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/orders/data/models/paymentRequest.dart';

void main() {
  group('PaymentRequest Model', () {
    final jsonString = '''
    {
      "shippingAddress": {
        "street": "123 Main St",
        "phone": "01010700999",
        "city": "Cairo",
        "lat": "30.0444",
        "long": "31.2357"
      }
    }
    ''';

    test('should deserialize JSON to PaymentRequest', () {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final paymentRequest = PaymentRequest.fromJson(jsonMap);

      expect(paymentRequest, isA<PaymentRequest>());
      expect(paymentRequest.shippingAddress?.street, "123 Main St");
      expect(paymentRequest.shippingAddress?.phone, "01010700999");
      expect(paymentRequest.shippingAddress?.city, "Cairo");
      expect(paymentRequest.shippingAddress?.lat, "30.0444");
      expect(paymentRequest.shippingAddress?.long, "31.2357");
    });

    test('should serialize PaymentRequest to JSON', () {
      final shippingAddress = ShippingAddress(
        street: "123 Main St",
        phone: "01010700999",
        city: "Cairo",
        lat: "30.0444",
        long: "31.2357",
      );

      final paymentRequest = PaymentRequest(shippingAddress: shippingAddress);
      final jsonMap = paymentRequest.toJson();

      expect(jsonMap['shippingAddress']['street'], "123 Main St");
      expect(jsonMap['shippingAddress']['phone'], "01010700999");
      expect(jsonMap['shippingAddress']['city'], "Cairo");
      expect(jsonMap['shippingAddress']['lat'], "30.0444");
      expect(jsonMap['shippingAddress']['long'], "31.2357");
    });
  });
}
