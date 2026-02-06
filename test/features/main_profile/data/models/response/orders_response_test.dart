import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';

void main() {
  final tOrderResponseJson = {
    "message": "success",
    "metadata": {
      "currentPage": 1,
      "totalPages": 1,
      "limit": 40,
      "totalItems": 1,
    },
    "orders": [
      {
        "shippingAddress": {
          "street": "123 Street",
          "city": "Cairo",
          "phone": "0123456789",
          "lat": "30.0",
          "long": "31.0",
        },
        "_id": "order_id",
        "totalPrice": 100,
        "isPaid": false,
        "isDelivered": false,
        "orderNumber": "ORD123",
      },
    ],
  };

  final tOrderResponseModel = OrderResponse(
    message: "success",
    metadata: Metadata(currentPage: 1, totalPages: 1, limit: 40, totalItems: 1),
    orders: [
      Order(
        id: "order_id",
        totalPrice: 100,
        isPaid: false,
        isDelivered: false,
        orderNumber: "ORD123",
        shippingAddress: ShippingAddress(
          street: "123 Street",
          city: "Cairo",
          phone: "0123456789",
          lat: "30.0",
          long: "31.0",
        ),
      ),
    ],
  );

  group('OrderResponse JSON Serialization', () {
    test('should return a valid model from JSON', () {
      // act
      final result = OrderResponse.fromJson(tOrderResponseJson);

      // assert
      expect(result.message, tOrderResponseModel.message);
      expect(
        result.metadata?.currentPage,
        tOrderResponseModel.metadata?.currentPage,
      );
      expect(result.orders?.length, tOrderResponseModel.orders?.length);
      expect(result.orders?[0].id, tOrderResponseModel.orders?[0].id);
      expect(
        result.orders?[0].shippingAddress?.city,
        tOrderResponseModel.orders?[0].shippingAddress?.city,
      );
    });

    test('should return a JSON map containing the proper data', () {
      // act
      final result = tOrderResponseModel.toJson();

      // assert
      expect(result["message"], tOrderResponseJson["message"]);
      expect(
        (result["metadata"] as Metadata).currentPage,
        tOrderResponseModel.metadata?.currentPage,
      );
      expect(
        (result["orders"] as List).length,
        (tOrderResponseJson["orders"] as List).length,
      );
    });
  });
}
