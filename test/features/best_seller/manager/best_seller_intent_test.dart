import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';

void main() {
  group('BestSellerIntent Tests', () {
    test('LoadBestSellersEvent should extend BestSellerIntent', () {
      final event = LoadBestSellersEvent();
      expect(event, isA<BestSellerIntent>());
    });

    test('LoadBestSellersEvent can be instantiated', () {
      final event1 = LoadBestSellersEvent();
      final event2 = LoadBestSellersEvent();
      
      // Both should be valid instances
      expect(event1.runtimeType, LoadBestSellersEvent);
      expect(event2.runtimeType, LoadBestSellersEvent);
    });

    test('LoadBestSellersEvent toString should be descriptive', () {
      final event = LoadBestSellersEvent();
      expect(event.toString(), contains('LoadBestSellersEvent'));
    });

    test('LoadBestSellersEvent should have no parameters', () {
      final event = LoadBestSellersEvent();
      // Just verify it can be created without parameters
      expect(event, isNotNull);
    });
  });
}