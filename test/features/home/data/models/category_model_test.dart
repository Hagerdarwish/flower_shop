import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/home/data/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart'
    as entity;

void main() {
  group('Category.toEntity', () {
    test('should convert Category to CategoryModel correctly', () {
      final category = Category(
        Id: "123",
        name: "Flowers",
        slug: "flowers",
        image: "flowers.png",
        createdAt: "2025-12-28",
        updatedAt: "2025-12-28",
        isSuperAdmin: true,
      );

      final entityModel = category.toEntity();

      expect(entityModel, isA<entity.CategoryModel>());
      expect(entityModel.id, "123");
      expect(entityModel.name, "Flowers");
      expect(entityModel.slug, "flowers");
      expect(entityModel.image, "flowers.png");
      expect(entityModel.createdAt, "2025-12-28");
      expect(entityModel.updatedAt, "2025-12-28");
      expect(entityModel.isSuperAdmin, true);
    });

    test('should handle null fields correctly', () {
      final category = Category();

      final entityModel = category.toEntity();

      expect(entityModel.id, '');
      expect(entityModel.name, '');
      expect(entityModel.slug, '');
      expect(entityModel.image, '');
      expect(entityModel.createdAt, null);
      expect(entityModel.updatedAt, null);
      expect(entityModel.isSuperAdmin, false);
    });
  });
}
