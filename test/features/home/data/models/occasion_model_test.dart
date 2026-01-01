import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/home/data/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart' as entity;

void main() {
  group('Occasion.toEntity', () {
    test('should convert Occasion to OccasionModel correctly', () {
      final occasion = Occasion(
        Id: "123",
        name: "Birthday",
        slug: "birthday",
        image: "birthday.png",
        createdAt: "2025-12-28T12:00:00Z",
        updatedAt: "2025-12-28T12:30:00Z",
        isSuperAdmin: true,
      );

      final entityModel = occasion.toEntity();

      expect(entityModel, isA<entity.OccasionModel>());
      expect(entityModel.id, "123");
      expect(entityModel.name, "Birthday");
      expect(entityModel.slug, "birthday");
      expect(entityModel.image, "birthday.png");
      expect(entityModel.createdAt, DateTime.parse("2025-12-28T12:00:00Z"));
      expect(entityModel.updatedAt, DateTime.parse("2025-12-28T12:30:00Z"));
      expect(entityModel.isSuperAdmin, true);
      expect(entityModel.productsCount, null);
    });

    test('should handle null fields correctly', () {
      final occasion = Occasion();

      final entityModel = occasion.toEntity();

      expect(entityModel, isA<entity.OccasionModel>());
      expect(entityModel.id, '');
      expect(entityModel.name, '');
      expect(entityModel.slug, '');
      expect(entityModel.image, '');
      expect(entityModel.createdAt, null);
      expect(entityModel.updatedAt, null);
      expect(entityModel.isSuperAdmin, false);
      expect(entityModel.productsCount, null);
    });
  });
}
