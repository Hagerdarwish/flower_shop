import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';

void main() {
  group('AllCategoriesDto JSON serialization', () {
    test('fromJson should parse correctly', () {
      final json = {
        'message': 'success',
        'metadata': {
          'currentPage': 1,
          'limit': 10,
          'totalPages': 5,
          'totalItems': 50,
        },
        'categories': [
          {
            '_id': '1',
            'name': 'Flowers',
            'slug': 'flowers',
            'image': 'image.png',
            'createdAt': '2024-01-01',
            'updatedAt': '2024-01-02',
            'isSuperAdmin': false,
            'productsCount': 12,
          },
        ],
      };

      final result = AllCategoriesDto.fromJson(json);

      expect(result.message, 'success');
      expect(result.metadata?.currentPage, 1);
      expect(result.categories?.length, 1);
      expect(result.categories?.first?.id, '1');
      expect(result.categories?.first?.name, 'Flowers');
    });

    test('toJson should parse correctly', () {
  final dto = AllCategoriesDto(
    message: 'success',
    metadata: MetadataDto(
      currentPage: 1,
      limit: 10,
      totalPages: 5,
      totalItems: 50,
    ),
    categories: [
      CategoryItemDto(
        id: '1',
        name: 'Flowers',
        slug: 'flowers',
        image: 'image.png',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-02',
        isSuperAdmin: false,
        productsCount: 12,
      ),
    ],
  );

  final metadataJson = dto.metadata?.toJson();
  final categoriesJson = dto.categories?.map((e) => e?.toJson()).toList();

  expect(dto.message, 'success');
  expect(metadataJson?['currentPage'], 1);
  expect(categoriesJson?[0]?['_id'], '1');
});
  });

  group('CategoryItemDto JSON serialization', () {
    test('fromJson works correctly', () {
      final json = {
        '_id': '10',
        'name': 'Roses',
        'slug': 'roses',
        'image': 'rose.png',
        'createdAt': '2024-01-01',
        'updatedAt': '2024-01-02',
        'isSuperAdmin': true,
        'productsCount': 8,
      };

      final result = CategoryItemDto.fromJson(json);

      expect(result.id, '10');
      expect(result.name, 'Roses');
      expect(result.slug, 'roses');
      expect(result.productsCount, 8);
      expect(result.isSuperAdmin, true);
    });

    test('toJson works correctly', () {
    final dto = CategoryItemDto(
      id: '10',
      name: 'Roses',
      slug: 'roses',
      image: 'rose.png',
      createdAt: '2024-01-01',
      updatedAt: '2024-01-02',
      isSuperAdmin: true,
      productsCount: 8,
    );

    final json = dto.toJson();

    expect(json['_id'], '10');
    expect(json['name'], 'Roses');
    expect(json['slug'], 'roses');
    expect(json['image'], 'rose.png');
    expect(json['createdAt'], '2024-01-01');
    expect(json['updatedAt'], '2024-01-02');
    expect(json['isSuperAdmin'], true);
    expect(json['productsCount'], 8);
  });
  });

  group('MetadataDto JSON serialization', () {
    test('toJson and fromJson should work correctly', () {
      final json = {
        'currentPage': 2,
        'limit': 20,
        'totalPages': 10,
        'totalItems': 200,
      };

      final dto = MetadataDto.fromJson(json);
      final resultJson = dto.toJson();

      expect(dto.currentPage, 2);
      expect(resultJson['limit'], 20);
      expect(resultJson['totalPages'], 10);
      expect(resultJson['totalItems'], 200);
    });
  });
}
