import 'package:flower_shop/features/commerce/data/mappers/all_categories_mapper.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AllCategoriesMapper', () {
    test('should map AllCategoriesDto to AllCategoriesModel correctly', () {
      final dto = AllCategoriesDto(
        message: 'success',
        categories: [
          CategoryItemDto(
            id: '1',
            name: 'Flowers',
            image: 'image.png',
            slug: 'flowers',
            productsCount: 10,
            createdAt: '2024-01-01',
            updatedAt: '2024-01-02',
            isSuperAdmin: false,
          ),
        ],
        metadata: MetadataDto(
          currentPage: 1,
          limit: 10,
          totalItems: 100,
          totalPages: 10,
        ),
      );

      final result = dto.toAllCategoriesModel();

      expect(result, isA<AllCategoriesModel>());
      expect(result.message, 'success');
      expect(result.categories?.length, 1);
      expect(result.categories?.first?.name, 'Flowers');
      expect(result.metadata?.currentPage, 1);
    });
  });

  group('CategoryItemMapper', () {
    test('should map CategoryItemDto to CategoryItemModel correctly', () {
      final dto = CategoryItemDto(
        id: '1',
        name: 'Roses',
        image: 'rose.png',
        slug: 'roses',
        productsCount: 5,
        isSuperAdmin: true,
      );

      final result = dto.toCategoryItemModel();

      expect(result.id, '1');
      expect(result.name, 'Roses');
      expect(result.image, 'rose.png');
      expect(result.productsCount, 5);
      expect(result.isSuperAdmin, true);
    });
  });

  group('MetaDataMapper', () {
    test('should map MetadataDto to MetadataModel correctly', () {
      final dto = MetadataDto(
        currentPage: 2,
        limit: 20,
        totalItems: 200,
        totalPages: 10,
      );

      final result = dto.toMetaDataModel();

      expect(result.currentPage, 2);
      expect(result.limit, 20);
      expect(result.totalItems, 200);
      expect(result.totalPages, 10);
    });
  });
}
