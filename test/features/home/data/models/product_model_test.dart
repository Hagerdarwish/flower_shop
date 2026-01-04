import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/home/data/models/product_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart'
    as entity;

void main() {
  group('Product.toEntity', () {
    test('should convert Product to ProductModel correctly', () {
      final product = Product(
        Id: "123",
        id: "456",
        title: "Red Rose",
        slug: "red-rose",
        description: "Beautiful red rose",
        imgCover: "cover.png",
        images: ["img1.png", "img2.png"],
        price: 100,
        priceAfterDiscount: 80,
        quantity: 10,
        category: "Flowers",
        occasion: "Birthday",
        createdAt: "2025-12-28T12:00:00Z",
        updatedAt: "2025-12-28T12:30:00Z",
        v: 1,
        isSuperAdmin: true,
        sold: 50,
        rateAvg: 5,
        rateCount: 10,
      );

      final entityModel = product.toEntity();

      expect(entityModel, isA<entity.ProductModel>());
      expect(entityModel.id, "456");
      expect(entityModel.title, "Red Rose");
      expect(entityModel.slug, "red-rose");
      expect(entityModel.description, "Beautiful red rose");
      expect(entityModel.imgCover, "cover.png");
      expect(entityModel.images?.length, 2);
      expect(entityModel.price, 100);
      expect(entityModel.priceAfterDiscount, 80);
      expect(entityModel.quantity, 10);
      expect(entityModel.category, "Flowers");
      expect(entityModel.occasion, "Birthday");
      expect(entityModel.createdAt, DateTime.parse("2025-12-28T12:00:00Z"));
      expect(entityModel.updatedAt, DateTime.parse("2025-12-28T12:30:00Z"));
      expect(entityModel.v, 1);
      expect(entityModel.isSuperAdmin, true);
      expect(entityModel.sold, 50);
      expect(entityModel.rateAvg, 5);
      expect(entityModel.rateCount, 10);
    });

    test('should handle null fields correctly', () {
      final product = Product();

      final entityModel = product.toEntity();

      expect(entityModel.id, '');
      expect(entityModel.title, '');
      expect(entityModel.slug, '');
      expect(entityModel.description, '');
      expect(entityModel.imgCover, '');
      expect(entityModel.images, []);
      expect(entityModel.price, 0);
      expect(entityModel.priceAfterDiscount, null);
      expect(entityModel.quantity, 0);
      expect(entityModel.category, '');
      expect(entityModel.occasion, '');
      expect(entityModel.createdAt, null);
      expect(entityModel.updatedAt, null);
      expect(entityModel.v, null);
      expect(entityModel.isSuperAdmin, false);
      expect(entityModel.sold, 0);
      expect(entityModel.rateAvg, 0);
      expect(entityModel.rateCount, 0);
    });
  });
}
