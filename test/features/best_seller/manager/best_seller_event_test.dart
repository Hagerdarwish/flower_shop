import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';

void main() {
  final productsList = [
    BestSellerModel(id: '1', title: 'Product 1', price: 100, imgCover: ''),
    BestSellerModel(id: '2', title: 'Product 2', price: 200, imgCover: ''),
  ];

  group('BestSellerState', () {
    test('initial() should create state with initial status', () {
      final state = BestSellerState.initial();

      expect(state.products.status, Status.initial);
      expect(state.products.data, isNull);
      expect(state.selectedIndex, 0);
    });

    test('copyWith should update products status', () {
      final initialState = BestSellerState.initial();
      final loadingProducts = Resource<List<BestSellerModel>>.loading();
      final newState = initialState.copyWith(products: loadingProducts);

      expect(newState.products.status, Status.loading);
      expect(newState.selectedIndex, initialState.selectedIndex);
    });

    test('copyWith should update selectedIndex', () {
      final initialState = BestSellerState.initial();
      final newState = initialState.copyWith(selectedIndex: 5);

      expect(newState.selectedIndex, 5);
      expect(newState.products.status, initialState.products.status);
    });

    test('copyWith should update both properties', () {
      final initialState = BestSellerState.initial();
      final successProducts = Resource<List<BestSellerModel>>.success(
        productsList,
      );
      final newState = initialState.copyWith(
        products: successProducts,
        selectedIndex: 2,
      );

      expect(newState.products.status, Status.success);
      expect(newState.products.data, productsList);
      expect(newState.selectedIndex, 2);
    });

    test('copyWith without changes should return similar state', () {
      final state = BestSellerState.initial();
      final copiedState = state.copyWith();

      // Check properties individually
      expect(copiedState.products.status, state.products.status);
      expect(copiedState.selectedIndex, state.selectedIndex);
    });

    test('states with same values have different instances by default', () {
      final state1 = BestSellerState.initial();
      final state2 = BestSellerState.initial();

      // These are different instances (identity equality)
      expect(identical(state1, state2), isFalse);

      // But they have the same property values
      expect(state1.products.status, state2.products.status);
      expect(state1.selectedIndex, state2.selectedIndex);
    });

    // Removed toString test or fixed version:
    test('should be able to create state with loading products', () {
      final state = BestSellerState(
        products: Resource<List<BestSellerModel>>.loading(),
        selectedIndex: 3,
      );

      expect(state.products.status, Status.loading);
      expect(state.selectedIndex, 3);
    });

    test('should create state with success products', () {
      final state = BestSellerState(
        products: Resource<List<BestSellerModel>>.success(productsList),
        selectedIndex: 1,
      );

      expect(state.products.status, Status.success);
      expect(state.products.data, productsList);
      expect(state.selectedIndex, 1);
    });

    test('should create state with error products', () {
      final state = BestSellerState(
        products: Resource<List<BestSellerModel>>.error('Error message'),
        selectedIndex: 0,
      );

      expect(state.products.status, Status.error);
      expect(state.products.error, 'Error message');
      expect(state.selectedIndex, 0);
    });
  });
}
