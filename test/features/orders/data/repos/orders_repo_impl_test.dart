import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/datasource/orders_remote_datasource.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flower_shop/features/orders/data/repos/orders_repo_impl.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDatasource])
void main() {
  late MockOrdersRemoteDatasource datasource;
  late OrdersRepoImpl repoImp;

  final fakePaymentResponse = PaymentResponse();

  setUpAll(() {
    provideDummy<ApiResult<UserCartsDto>>(
      SuccessApiResult(data: UserCartsDto()),
    );
    provideDummy<ApiResult<PaymentResponse>>(
      SuccessApiResult(data: fakePaymentResponse),
    );
  });

  setUp(() {
    datasource = MockOrdersRemoteDatasource();
    repoImp = OrdersRepoImpl(datasource);
  });
  group("Payment", () {
    test('should return SuccessApiResult when payment succeeds', () async {
      when(
        datasource.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          request: anyNamed('request'),
        ),
      ).thenAnswer(
        (_) async =>
            SuccessApiResult<PaymentResponse>(data: fakePaymentResponse),
      );

      final result = await repoImp.payment(
        token: 'token',
        returnUrl: 'returnUrl',
        street: 'street',
        phone: '0100000000',
        city: 'Cairo',
        lat: '0',
        long: '0',
      );

      expect(result, isA<SuccessApiResult<PaymentResponse>>());
      expect((result as SuccessApiResult).data, fakePaymentResponse);
      verify(
        datasource.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          request: anyNamed('request'),
        ),
      ).called(1);
    });

    test('should return ErrorApiResult when payment fails', () async {
      when(
        datasource.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          request: anyNamed('request'),
        ),
      ).thenAnswer(
        (_) async => ErrorApiResult<PaymentResponse>(error: 'Network error'),
      );

      final result = await repoImp.payment(
        token: 'token',
        returnUrl: 'returnUrl',
        street: 'street',
        phone: '0100000000',
        city: 'Cairo',
        lat: '0',
        long: '0',
      );

      expect(result, isA<ErrorApiResult<PaymentResponse>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(
        datasource.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          request: anyNamed('request'),
        ),
      ).called(1);
    });
  });

  group("Get user carts", () {
    test('should return ApiSuccess when get all user carts success', () async {
      final fakeDto = UserCartsDto(
        message: 'success',
        numOfCartItems: 4,
        cart: CartDto(
          id: 'cart1',
          totalPrice: 1620,
          cartItems: [
            CartItemsDto(
              id: 'item1',
              quantity: 2,
              product: ProductCartDto(
                id: 'prod1',
                title: 'Rose Bouquet',
                imgCover: 'url_to_image',
                price: 500,
                priceAfterDiscount: 420,
              ),
            ),
            CartItemsDto(
              id: 'item2',
              quantity: 1,
              product: ProductCartDto(
                id: 'prod2',
                title: 'Lily Bouquet',
                imgCover: 'url_to_image',
                price: 1500,
                priceAfterDiscount: 1200,
              ),
            ),
          ],
        ),
      );

      when(
        datasource.getUserCarts(),
      ).thenAnswer((_) async => SuccessApiResult<UserCartsDto>(data: fakeDto));

      final result =
          await repoImp.getUserCarts() as SuccessApiResult<UserCartsModel>;

      expect(result, isA<SuccessApiResult<UserCartsModel>>());
      expect(result.data.message, fakeDto.message);
      expect(result.data.cart?.id, fakeDto.cart?.id);
      verify(datasource.getUserCarts()).called(1);
    });

    test('should return ApiError when get all user carts fails', () async {
      when(datasource.getUserCarts()).thenAnswer(
        (_) async => ErrorApiResult<UserCartsDto>(error: 'Network error'),
      );

      final result =
          await repoImp.getUserCarts() as ErrorApiResult<UserCartsModel>;

      expect(result, isA<ErrorApiResult<UserCartsModel>>());
      expect(result.error.toString(), contains("Network error"));
      verify(datasource.getUserCarts()).called(1);
    });
  });

  group("Add product to cart", () {
    test('should return ApiSuccess when add product to cart success', () async {
      final fakeDto = UserCartsDto(
        message: 'success',
        numOfCartItems: 4,
        cart: CartDto(id: 'cart1', totalPrice: 1620, cartItems: []),
      );

      when(
        datasource.addProductToCart(product: 'Rose Bouquet', quantity: 2),
      ).thenAnswer((_) async => SuccessApiResult<UserCartsDto>(data: fakeDto));

      final result =
          await repoImp.addProductToCart(product: 'Rose Bouquet', quantity: 2)
              as SuccessApiResult<UserCartsModel>;

      expect(result, isA<SuccessApiResult<UserCartsModel>>());
      expect(result.data.message, fakeDto.message);
      verify(
        datasource.addProductToCart(product: 'Rose Bouquet', quantity: 2),
      ).called(1);
    });

    test('should return ApiError when add product to cart fails', () async {
      when(
        datasource.addProductToCart(product: 'Rose Bouquet', quantity: 2),
      ).thenAnswer(
        (_) async => ErrorApiResult<UserCartsDto>(error: 'Network error'),
      );

      final result =
          await repoImp.addProductToCart(product: 'Rose Bouquet', quantity: 2)
              as ErrorApiResult<UserCartsModel>;

      expect(result, isA<ErrorApiResult<UserCartsModel>>());
      expect(result.error.toString(), contains("Network error"));
      verify(
        datasource.addProductToCart(product: 'Rose Bouquet', quantity: 2),
      ).called(1);
    });
  });

  group("Delete cart item", () {
    test('should return ApiSuccess when delete cart item success', () async {
      final fakeDto = UserCartsDto(
        message: 'success',
        numOfCartItems: 4,
        cart: CartDto(id: 'cart1', totalPrice: 1620, cartItems: []),
      );

      when(
        datasource.deleteCartItem(cartItemId: 'item1'),
      ).thenAnswer((_) async => SuccessApiResult<UserCartsDto>(data: fakeDto));

      final result =
          await repoImp.deleteCartItem(cartItemId: 'item1')
              as SuccessApiResult<UserCartsModel>;

      expect(result, isA<SuccessApiResult<UserCartsModel>>());
      expect(result.data.message, fakeDto.message);
      verify(datasource.deleteCartItem(cartItemId: 'item1')).called(1);
    });

    test('should return ApiError when delete cart item fails', () async {
      when(datasource.deleteCartItem(cartItemId: 'item1')).thenAnswer(
        (_) async => ErrorApiResult<UserCartsDto>(error: 'Network error'),
      );

      final result =
          await repoImp.deleteCartItem(cartItemId: 'item1')
              as ErrorApiResult<UserCartsModel>;

      expect(result, isA<ErrorApiResult<UserCartsModel>>());
      expect(result.error.toString(), contains("Network error"));
      verify(datasource.deleteCartItem(cartItemId: 'item1')).called(1);
    });
  });

  group("Update cart item quantity", () {
    test(
      'should return ApiSuccess when update cart item quantity success',
      () async {
        final fakeDto = UserCartsDto(
          message: 'success',
          numOfCartItems: 4,
          cart: CartDto(id: 'cart1', totalPrice: 1620, cartItems: []),
        );

        when(
          datasource.updateCartItemQuantity(cartItemId: 'item1', quantity: 3),
        ).thenAnswer(
          (_) async => SuccessApiResult<UserCartsDto>(data: fakeDto),
        );

        final result =
            await repoImp.updateCartItemQuantity(
                  cartItemId: 'item1',
                  quantity: 3,
                )
                as SuccessApiResult<UserCartsModel>;

        expect(result, isA<SuccessApiResult<UserCartsModel>>());
        expect(result.data.message, fakeDto.message);
        verify(
          datasource.updateCartItemQuantity(cartItemId: 'item1', quantity: 3),
        ).called(1);
      },
    );

    test(
      'should return ApiError when update cart item quantity fails',
      () async {
        when(
          datasource.updateCartItemQuantity(cartItemId: 'item1', quantity: 3),
        ).thenAnswer(
          (_) async => ErrorApiResult<UserCartsDto>(error: 'Network error'),
        );

        final result =
            await repoImp.updateCartItemQuantity(
                  cartItemId: 'item1',
                  quantity: 3,
                )
                as ErrorApiResult<UserCartsModel>;

        expect(result, isA<ErrorApiResult<UserCartsModel>>());
        expect(result.error.toString(), contains("Network error"));
        verify(
          datasource.updateCartItemQuantity(cartItemId: 'item1', quantity: 3),
        ).called(1);
      },
    );
  });
}
