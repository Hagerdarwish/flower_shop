import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';

void main() {
  group('AllCategoriesModel', () {
    test('should create instance with correct values', () {
      final metadata = MetadataModel(
        currentPage: 1,
        limit: 10,
        totalPages: 5,
        totalItems: 50,
      );

      final categories = [
        CategoryItemModel(
          id: '1',
          name: 'Flowers',
          slug: 'flowers',
          image: 'image.png',
          createdAt: '2024-01-01',
          updatedAt: '2024-01-02',
          isSuperAdmin: false,
          productsCount: 12,
        ),
      ];

      final model = AllCategoriesModel(
        message: 'success',
        metadata: metadata,
        categories: categories,
      );

      expect(model.message, 'success');
      expect(model.metadata?.currentPage, 1);
      expect(model.metadata?.limit, 10);
      expect(model.metadata?.totalPages, 5);
      expect(model.metadata?.totalItems, 50);
      expect(model.categories?[0]?.id, '1');
      expect(model.categories?[0]?.name, 'Flowers');
      expect(model.categories?[0]?.image, 'image.png');
      expect(model.categories?[0]?.productsCount, 12);
    });
  });

  group('CategoryItemModel', () {
    test('should create instance correctly', () {
      final category = CategoryItemModel(
        id: '2',
        name: 'Roses',
        image: 'rose.png',
        isSuperAdmin: true,
        productsCount: 8,
      );

      expect(category.id, '2');
      expect(category.name, 'Roses');
      expect(category.image, 'rose.png');
      expect(category.isSuperAdmin, true);
      expect(category.productsCount, 8);
    });
  });

  group('MetadataModel', () {
    test('should create instance correctly', () {
      final metadata = MetadataModel(
        currentPage: 3,
        limit: 15,
        totalPages: 10,
        totalItems: 150,
      );

      expect(metadata.currentPage, 3);
      expect(metadata.limit, 15);
      expect(metadata.totalPages, 10);
      expect(metadata.totalItems, 150);
    });
  });
}
