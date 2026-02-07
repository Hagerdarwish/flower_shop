import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserCartsModel', () {
    test('should create instance with correct values', () {
      final model = UserCartsModel(
        message: 'Cart retrieved successfully',
        error: null,
        numOfCartItems: 3,
        cart: CartModel(id: 'cart123'),
      );

      expect(model.message, 'Cart retrieved successfully');
      expect(model.error, null);
      expect(model.numOfCartItems, 3);
      expect(model.cart?.id, 'cart123');
    });
  });

  group('CartModel', () {
    test('should create instance with correct values', () {
      final model = CartModel(
        id: 'cart123',
        totalPrice: 2600,
        user: 'user456',
        createdAt: '2024-01-01',
        cartItems: [
          CartItemsModel(
            id: 'item789',
            price: 1000,
            quantity: 2,
            product: ProductCartModel(title: 'Rose Bouquet'),
          ),
          CartItemsModel(
            id: 'item79',
            price: 600,
            quantity: 1,
            product: ProductCartModel(title: 'Red Flowers'),
          ),
        ],
      );

      expect(model.id, 'cart123');
      expect(model.totalPrice, 2600);
      expect(model.user, 'user456');
      expect(model.createdAt, '2024-01-01');
      expect(model.cartItems?.length, 2);
      expect(model.cartItems?[0]?.price, 1000);
      expect(model.cartItems?[1]?.quantity, 1);
      expect(model.cartItems?[1]?.product?.title, 'Red Flowers');
    });
  });

  group('CartItemsModel', () {
    test('should create instance with correct values', () {
      final model = CartItemsModel(
        id: 'item789',
        price: 1500,
        quantity: 3,
        product: ProductCartModel(
          id: 'prod123',
          title: 'Tulip Bouquet',
          price: 500,
        ),
      );

      expect(model.id, 'item789');
      expect(model.price, 1500);
      expect(model.quantity, 3);
      expect(model.product?.id, 'prod123');
      expect(model.product?.title, 'Tulip Bouquet');
      expect(model.product?.price, 500);
    });
  });

  group('ProductCartModel', () {
    test('should create instance with correct values', () {
      final model = ProductCartModel(
        id: 'prod123',
        title: 'Sunflower Bouquet',
        description: 'A beautiful bouquet of sunflowers.',
        imgCover: 'sunflower.png',
        price: 1200,
        priceAfterDiscount: 1000,
        quantity: 50,
      );

      expect(model.id, 'prod123');
      expect(model.title, 'Sunflower Bouquet');
      expect(model.description, 'A beautiful bouquet of sunflowers.');
      expect(model.imgCover, 'sunflower.png');
      expect(model.price, 1200);
      expect(model.priceAfterDiscount, 1000);
      expect(model.quantity, 50);
    });
  });
}
