import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/home/data/models/product_model.dart';
import 'package:flower_shop/features/home/data/models/category_model.dart';
import 'package:flower_shop/features/home/data/models/best_seller_model.dart';
import 'package:flower_shop/features/home/data/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';

void main() {
  group('HomeResponse.toEntity', () {
    test('should convert HomeResponse to HomeModel correctly', () {
      // ARRANGE
      final homeResponse = HomeResponse(
        message: "Welcome",
        products: [
          Product(id: "1", title: "Rose", price: 10, imgCover: "img.png")
        ],
        categories: [
          Category(Id: "1", name: "Flowers")
        ],
        bestSeller: [
          BestSeller(id: "1", title: "Rose Bouquet")
        ],
        occasions: [
          Occasion(Id: "1", name: "Birthday")
        ],
      );

      // ACT
      final homeModel = homeResponse.toEntity();

      // ASSERT
      expect(homeModel, isA<HomeModel>());
      expect(homeModel.message, "Welcome");
      expect(homeModel.products?.length, 1);
      expect(homeModel.products?.first.title, "Rose");
      expect(homeModel.categories?.length, 1);
      expect(homeModel.categories?.first.name, "Flowers");
      expect(homeModel.bestSeller?.length, 1);
      expect(homeModel.bestSeller?.first.title, "Rose Bouquet");
      expect(homeModel.occasions?.length, 1);
      expect(homeModel.occasions?.first.name, "Birthday");
    });

    test('should handle null lists correctly', () {
      // ARRANGE
      final homeResponse = HomeResponse(
        message: null,
        products: null,
        categories: null,
        bestSeller: null,
        occasions: null,
      );

      // ACT
      final homeModel = homeResponse.toEntity();

      // ASSERT
      expect(homeModel.message, '');
      expect(homeModel.products, isEmpty);
      expect(homeModel.categories, isEmpty);
      expect(homeModel.bestSeller, isEmpty);
      expect(homeModel.occasions, isEmpty);
    });
  });
}
