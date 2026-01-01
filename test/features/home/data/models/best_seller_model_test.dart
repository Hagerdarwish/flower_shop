import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/home/data/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart' as entity;

void main() {
  group('BestSeller.toEntity', () {
    test('should convert BestSeller to BestSellerModel correctly', () {
      final bestSeller = BestSeller(
        Id: "123",
        id: "456",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "Beautiful roses",
        imgCover: "cover.png",
        images: ["img1.png", "img2.png"],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 5,
        category: "Flowers",
        occasion: "Birthday",
        createdAt: "2025-12-28",
        updatedAt: "2025-12-28",
        v: 1,
        isSuperAdmin: true,
        sold: 10,
        rateAvg: 5,
        rateCount: 20,
      );

      final entityModel = bestSeller.toEntity();
      expect(entityModel, isA<entity.BestSellerModel>());
      expect(entityModel.id, "456");
      expect(entityModel.title, "Rose Bouquet");
      expect(entityModel.slug, "rose-bouquet");
      expect(entityModel.description, "Beautiful roses");
      expect(entityModel.imgCover, "cover.png");
      expect(entityModel.images?.length, 2);
      expect(entityModel.price, 100);
      expect(entityModel.priceAfterDiscount, 80);
      expect(entityModel.quantity, 5);
      expect(entityModel.category, "Flowers");
      expect(entityModel.occasion, "Birthday");
      expect(entityModel.createdAt, "2025-12-28");
      expect(entityModel.updatedAt, "2025-12-28");
      expect(entityModel.v, 1);
      expect(entityModel.isSuperAdmin, true);
      expect(entityModel.sold, 10);
      expect(entityModel.rateAvg, 5);
      expect(entityModel.rateCount, 20);
    });

    test('should handle null fields correctly', () {

      final bestSeller = BestSeller();
      final entityModel = bestSeller.toEntity();

      expect(entityModel.id, '');
      expect(entityModel.title, '');
      expect(entityModel.slug, '');
      expect(entityModel.description, '');
      expect(entityModel.imgCover, '');
      expect(entityModel.images, []);
      expect(entityModel.price, 0);
      expect(entityModel.quantity, 0);
      expect(entityModel.category, '');
      expect(entityModel.occasion, '');
      expect(entityModel.isSuperAdmin, false);
      expect(entityModel.sold, 0);
      expect(entityModel.rateAvg, 0);
      expect(entityModel.rateCount, 0);
    });
  });
}
