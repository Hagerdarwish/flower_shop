import 'package:flower_shop/features/orders/data/mappers/user_carts_dto_mapper.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserCartsMapper', () {
    test('should map UserCartsDto to UserCartsModel correctly', () {
      final dto = UserCartsDto(
        message: 'Cart fetched successfully',
        error: 'error',
        numOfCartItems: 3,
        cart: CartDto(
          id: 'cart123',
          user: 'user456',
          totalPrice: 150,
          cartItems: [
            CartItemsDto(
              id: 'item789',
              price: 50,
              quantity: 1,
              product: ProductCartDto(
                id: 'prod101',
                price: 50,
                description: 'A flower',
                title: 'Rose',
                imgCover: 'rose.png',
                quantity: 100,
                priceAfterDiscount: 45,
              ),
            ),
          ],
        ),
      );

      final result = dto.toUserCartsModel();

      expect(result, isA<UserCartsModel>());
      expect(result.message, 'Cart fetched successfully');
      expect(result.error, dto.error);
      expect(result.numOfCartItems, dto.numOfCartItems);
      expect(result.cart?.id, dto.cart?.id);
      expect(result.cart?.user, dto.cart?.user);
      expect(result.cart?.totalPrice, dto.cart?.totalPrice);
      expect(result.cart?.cartItems?.length, 1);
    });
  });

  group('CartMapper', () {
    test('should map CartDto to CartModel correctly', () {
      final dto = CartDto(
        id: 'cart123',
        user: 'user456',
        totalPrice: 150,
        cartItems: [
          CartItemsDto(
            id: 'item789',
            price: 50,
            quantity: 1,
            product: ProductCartDto(
              id: 'prod101',
              price: 50,
              description: 'A flower',
              title: 'Rose',
              imgCover: 'rose.png',
              quantity: 100,
              priceAfterDiscount: 45,
            ),
          ),
        ],
      );

      final result = dto.toCartModel();

      expect(result, isA<CartModel>());
      expect(result.id, dto.id);
      expect(result.user, dto.user);
      expect(result.totalPrice, dto.totalPrice);
      expect(result.cartItems?.length, 1);
    });
  });

  group('CartItemMapper', () {
    test('should map CartItemsDto to CartItemsModel correctly', () {
      final dto = CartItemsDto(
        id: 'item789',
        price: 50,
        quantity: 1,
        product: ProductCartDto(
          id: 'prod101',
          price: 50,
          description: 'A flower',
          title: 'Rose',
          imgCover: 'rose.png',
          quantity: 100,
          priceAfterDiscount: 45,
        ),
      );

      final result = dto.toCartItemModel();

      expect(result, isA<CartItemsModel>());
      expect(result.id, dto.id);
      expect(result.price, dto.price);
      expect(result.quantity, dto.quantity);
    });
  });

  group('ProductCartMapper', () {
    test('should map ProductCartDto to ProductCartModel correctly', () {
      final dto = ProductCartDto(
        id: 'prod101',
        price: 50,
        description: 'A flower',
        title: 'Rose',
        imgCover: 'rose.png',
        quantity: 100,
        priceAfterDiscount: 45,
      );

      final result = dto.toProductCartModel();

      expect(result, isA<ProductCartModel>());
      expect(result.id, 'prod101');
      expect(result.price, 50);
      expect(result.description, dto.description);
      expect(result.title, dto.title);
      expect(result.imgCover, dto.imgCover);
      expect(result.quantity, dto.quantity);
      expect(result.priceAfterDiscount, 45);
    });
  });
}
