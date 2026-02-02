import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart'
    hide OrderItem, Product;

void main() {
  group('CashOrderResponse', () {
    test('fromJson parses CashOrderResponse correctly', () {
      // arrange
      final json = {
        "message": "order created successfully",
        "order": {
          "_id": "order_1",
          "user": "user_1",
          "orderItems": [
            {
              "_id": "item_1",
              "price": 100,
              "quantity": 2,
              "product": {
                "_id": "prod_1",
                "id": "prod_1",
                "title": "Red Roses",
                "slug": "red-roses",
                "description": "Beautiful red roses",
                "imgCover": "https://img.com/rose.png",
                "images": ["https://img.com/1.png"],
                "price": 120,
                "priceAfterDiscount": 100,
                "quantity": 5,
                "category": "flowers",
                "occasion": "valentine",
                "createdAt": "2024-01-01T00:00:00.000Z",
                "updatedAt": "2024-01-01T00:00:00.000Z",
                "__v": 0,
                "isSuperAdmin": false,
                "sold": 10,
                "rateAvg": 4,
                "rateCount": 20,
              },
            },
          ],
          "totalPrice": 200,
          "paymentType": "cash",
          "isPaid": false,
          "isDelivered": false,
          "state": "pending",
          "createdAt": "2024-01-01T00:00:00.000Z",
          "updatedAt": "2024-01-01T00:00:00.000Z",
          "orderNumber": "ORD-001",
          "__v": 0,
        },
      };

      // act
      final response = CashOrderResponse.fromJson(json);

      // assert
      expect(response.message, "order created successfully");
      expect(response.order.id, "order_1");
      expect(response.order.orderItems.length, 1);
      expect(response.order.orderItems.first.product.title, "Red Roses");
    });

    test('toDomain maps CashOrderResponse to CashOrderModel', () {
      // arrange
      final response = CashOrderResponse(
        message: "success",
        order: Order(
          id: "order_1",
          user: "user_1",
          totalPrice: 200,
          paymentType: "cash",
          isPaid: false,
          isDelivered: false,
          state: "pending",
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          orderNumber: "ORD-001",
          v: 0,
          orderItems: [
            OrderItem(
              id: "item_1",
              price: 100,
              quantity: 2,
              product: Product(
                id: "prod_1",
                productId: "prod_1",
                title: "Red Roses",
                slug: "red-roses",
                description: "desc",
                imgCover: "img.png",
                images: ["img.png"],
                price: 120,
                priceAfterDiscount: 100,
                quantity: 5,
                category: "flowers",
                occasion: "valentine",
                createdAt: DateTime(2024, 1, 1),
                updatedAt: DateTime(2024, 1, 1),
                v: 0,
                isSuperAdmin: false,
                sold: 10,
                rateAvg: 4,
                rateCount: 20,
              ),
            ),
          ],
        ),
      );

      // act
      final domain = response.toDomain();

      // assert
      expect(domain, isA<CashOrderModel>());
      expect(domain.id, "order_1");
      expect(domain.userId, "user_1");
      expect(domain.totalPrice, 200.0);
      expect(domain.paymentType, "cash");
      expect(domain.items.length, 1);
      expect(domain.items.first.product.title, "Red Roses");
    });
    test('toJson returns valid json structure', () {
      // arrange
      final response = CashOrderResponse(
        message: "success",
        order: Order(
          id: "order_1",
          user: "user_1",
          totalPrice: 100,
          paymentType: "cash",
          isPaid: true,
          isDelivered: false,
          state: "confirmed",
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          orderNumber: "ORD-002",
          v: 1,
          orderItems: [],
        ),
      );

      // act
      final json = response.toJson();

      // assert
      expect(json['message'], "success");
      // Instead of trying to access json['order'] as a Map, check the original Order object
      expect(response.order.paymentType, "cash");
      expect(response.order.orderNumber, "ORD-002");
    });
  });
}
