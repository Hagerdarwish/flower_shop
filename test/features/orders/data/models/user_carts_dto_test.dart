import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserCartsDto Json serialization', () {
    test('fromJson should parse correctly', () {
      final json = {
        'message': 'Cart fetched successfully',
        'error': null,
        'numOfCartItems': 2,
        'cart': {
          '_id': 'cart123',
          'totalPrice': 150,
          'cartItems': [
            {
              'quantity': 2,
              'price': 75,
              'product': {
                '_id': 'flower1',
                'title': 'Tulip',
                'slug': 'tulip',
                'price': 75,
                'category': 'flowers',
                'image': 'tulip.png',
              },
            },
            {
              'quantity': 1,
              'price': 75,
              'product': {
                '_id': 'flower2',
                'title': 'Rose',
                'slug': 'rose',
                'price': 75,
                'category': 'flowers',
                'image': 'rose.png',
              },
            },
          ],
        },
      };

      final result = UserCartsDto.fromJson(json);

      expect(result.message, 'Cart fetched successfully');
      expect(result.numOfCartItems, 2);
      expect(result.cart?.id, 'cart123');
      expect(result.cart?.totalPrice, 150);
      expect(result.cart?.cartItems?.length, 2);
      expect(result.cart?.cartItems?[0]?.quantity, 2);
      expect(result.cart?.cartItems?[0]?.product?.title, 'Tulip');
    });
    test('toJson should parse correctly', () {
      final dto = UserCartsDto(
        message: 'success',
        error: 'error message',
        numOfCartItems: 2,
        cart: CartDto(
          id: 'cart123',
          totalPrice: 150,
          cartItems: [
            CartItemsDto(
              quantity: 2,
              price: 75,
              product: ProductCartDto(
                id: 'flower1',
                title: 'Tulip',
                slug: 'tulip',
                price: 75,
                category: 'flowers',
                imgCover: 'tulip.png',
              ),
            ),
            CartItemsDto(
              quantity: 1,
              price: 200,
              product: ProductCartDto(
                id: 'flower2',
                title: 'Rose',
                slug: 'rose',
                price: 200,
                category: 'flowers',
                imgCover: 'rose.png',
              ),
            ),
          ],
        ),
      );

      final cart = dto.cart!;
      final cartItems = cart.cartItems!;

      expect(dto.message, 'success');
      expect(dto.numOfCartItems, 2);
      expect(cart.totalPrice, 150);
      expect(cartItems[0]?.quantity, 2);
      expect(cartItems[0]?.product?.title, 'Tulip');
      expect(cartItems[1]?.price, 200);
      expect(cartItems[1]?.product?.title, 'Rose');
    });
  });

  group('CartDto Json serialization', () {
    test('fromJson should parse correctly', () {
      final json = {
        '_id': 'cart1',
        'totalPrice': 150,
        'cartItems': [
          {
            'quantity': 2,
            'price': 75,
            'product': {
              '_id': 'flower1',
              'title': 'Tulip',
              'slug': 'tulip',
              'price': 75,
              'category': 'flowers',
              'image': 'tulip.png',
            },
          },
          {
            'quantity': 1,
            'price': 75,
            'product': {
              '_id': 'flower2',
              'title': 'Rose',
              'slug': 'rose',
              'price': 75,
              'category': 'flowers',
              'image': 'rose.png',
            },
          },
        ],
      };

      final result = CartDto.fromJson(json);

      expect(result.id, 'cart1');
      expect(result.totalPrice, 150);
      expect(result.cartItems?.length, 2);
      expect(result.cartItems?[0]?.quantity, 2);
      expect(result.cartItems?[0]?.product?.title, 'Tulip');
    });

    test('toJson should parse correctly', () {
      final dto = CartDto(
        id: 'cart123',
        totalPrice: 150,
        cartItems: [
          CartItemsDto(
            quantity: 2,
            price: 75,
            product: ProductCartDto(
              id: 'flower1',
              title: 'Tulip',
              slug: 'tulip',
              price: 75,
              category: 'flowers',
              imgCover: 'tulip.png',
            ),
          ),
          CartItemsDto(
            quantity: 1,
            price: 200,
            product: ProductCartDto(
              id: 'flower2',
              title: 'Rose',
              slug: 'rose',
              price: 200,
              category: 'flowers',
              imgCover: 'rose.png',
            ),
          ),
        ],
      );

      final cart = dto.toJson();

      expect(cart['totalPrice'], 150);
      expect(cart['cartItems'][0]?.quantity, 2);
      expect(cart['cartItems'][0]?.product?.title, 'Tulip');
      expect(cart['cartItems'][1]?.price, 200);
      expect(cart['cartItems'][1]?.product?.title, 'Rose');
    });
  });

  group('CartItemsDto Json serialization', () {
    test('fromJson should parse correctly', () {
      final json = {
        'quantity': 2,
        'price': 155,
        'product': {
          '_id': 'flower1',
          'title': 'Tulip',
          'slug': 'tulip',
          'price': 75,
          'category': 'flowers',
          'image': 'tulip.png',
        },
      };

      final result = CartItemsDto.fromJson(json);

      expect(result.quantity, 2);
      expect(result.price, 155);
      expect(result.product?.title, 'Tulip');
      expect(result.product?.id, 'flower1');
    });

    test('toJson should parse correctly', () {
      final dto = CartItemsDto(
        quantity: 2,
        price: 200,
        product: ProductCartDto(
          id: 'flower1',
          title: 'Tulip',
          slug: 'tulip',
          price: 200,
          category: 'flowers',
          imgCover: 'tulip.png',
        ),
      );

      final cart = dto.toJson();

      expect(cart['quantity'], 2);
      expect(cart['price'], 200);
      expect(cart['product']?.title, 'Tulip');
      expect(cart['product']?.id, 'flower1');
    });
  });

  group('ProductCartDto Json serialization', () {
    test('fromJson should parse correctly', () {
      final json = {
        '_id': 'flower1',
        'title': 'Tulip',
        'slug': 'tulip',
        'price': 375,
        'quantity': 10,
        'description': 'anniversary flower',
        'category': 'flowers',
        'image': 'tulip.png',
      };

      final result = ProductCartDto.fromJson(json);

      expect(result.quantity, 10);
      expect(result.price, 375);
      expect(result.title, 'Tulip');
      expect(result.id, 'flower1');
    });

    test('toJson should parse correctly', () {
      final dto = ProductCartDto(
        id: 'flower1',
        title: 'Tulip',
        slug: 'tulip',
        price: 200,
        category: 'flowers',
        imgCover: 'tulip.png',
        quantity: 10,
        description: 'anniversary flower',
      );

      final cart = dto.toJson();

      expect(cart['quantity'], 10);
      expect(cart['price'], 200);
      expect(cart['title'], 'Tulip');
      expect(cart['description'], 'anniversary flower');
    });
  });
}
