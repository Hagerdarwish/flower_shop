import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/api/datasource/orders_remote_datasource_impl.dart';
import 'package:flower_shop/features/orders/data/models/paymentRequest.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'orders_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late OrdersRemoteDatasourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = OrdersRemoteDatasourceImpl(mockApiClient);
  });

  group("OrdersRemoteDatasourceImpl.getUserCarts()", () {
    test('should return ApiSuccess when get all carts succeeds', () async {
      final fakeDto = UserCartsDto(
        error: 'error',
        message: 'Success',
        numOfCartItems: 2,
        cart: CartDto(
          id: 'cartId',
          totalPrice: 1500,
          cartItems: [
            CartItemsDto(
              id: 'itemId1',
              product: ProductCartDto(
                id: 'prodId1',
                title: 'Rose Flower',
                description: 'Red Rose',
                price: 500,
              ),
              quantity: 2,
            ),
            CartItemsDto(
              id: 'itemId2',
              product: ProductCartDto(
                id: 'prodId2',
                title: 'Tulip',
                description: 'Yellow Tulip',
                price: 1000,
              ),
              quantity: 1,
            ),
          ],
        ),
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/cart'),
          statusCode: 200,
        ),
      );
      when(mockApiClient.getUserCarts()).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.getUserCarts() as SuccessApiResult<UserCartsDto>;

      expect(result, isA<SuccessApiResult<UserCartsDto>>());
      expect(result.data.error, fakeDto.error);
      expect(result.data.message, fakeDto.message);
      expect(result.data.numOfCartItems, fakeDto.numOfCartItems);
      verify(mockApiClient.getUserCarts()).called(1);
    });

    test('should return ApiError when cart throws exception', () async {
      when(mockApiClient.getUserCarts()).thenThrow(Exception('Network error'));

      final result =
          await dataSource.getUserCarts() as ErrorApiResult<UserCartsDto>;

      expect(result, isA<ErrorApiResult<UserCartsDto>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.getUserCarts()).called(1);
    });
  });

  group("OrdersRemoteDatasourceImpl.addProductToCart()", () {
    test(
      'should return ApiSuccess when add product to cart succeeds',
      () async {
        final fakeDto = UserCartsDto(
          error: 'error',
          message: 'Success',
          numOfCartItems: 2,
          cart: CartDto(
            id: 'cartId',
            totalPrice: 1500,
            cartItems: [
              CartItemsDto(
                id: 'itemId1',
                product: ProductCartDto(
                  id: 'prodId1',
                  title: 'Rose Flower',
                  description: 'Red Rose',
                  price: 500,
                ),
                quantity: 2,
              ),
              CartItemsDto(
                id: 'itemId2',
                product: ProductCartDto(
                  id: 'prodId2',
                  title: 'Tulip',
                  description: 'Yellow Tulip',
                  price: 1000,
                ),
                quantity: 1,
              ),
            ],
          ),
        );
        final fakeResponse = HttpResponse(
          fakeDto,
          Response(
            requestOptions: RequestOptions(path: '/cart'),
            statusCode: 200,
          ),
        );
        when(
          mockApiClient.addProductToCart(any),
        ).thenAnswer((_) async => fakeResponse);

        final result =
            await dataSource.addProductToCart()
                as SuccessApiResult<UserCartsDto>;

        expect(result, isA<SuccessApiResult<UserCartsDto>>());
        expect(result.data.error, fakeDto.error);
        expect(result.data.message, fakeDto.message);
        expect(result.data.numOfCartItems, fakeDto.numOfCartItems);
        verify(mockApiClient.addProductToCart(any)).called(1);
      },
    );
    test(
      'should return ApiError when add product to cart throws exception',
      () async {
        when(
          mockApiClient.addProductToCart(any),
        ).thenThrow(Exception('Network error'));

        final result =
            await dataSource.addProductToCart() as ErrorApiResult<UserCartsDto>;

        expect(result, isA<ErrorApiResult<UserCartsDto>>());
        expect(result.error.toString(), contains("Network error"));
        verify(mockApiClient.addProductToCart(any)).called(1);
      },
    );
  });

  group("OrdersRemoteDatasourceImpl.deleteCartItem()", () {
    test('should return ApiSuccess when delete cart item succeeds', () async {
      final fakeDto = UserCartsDto(
        error: 'error',
        message: 'Success',
        numOfCartItems: 2,
        cart: CartDto(
          id: 'cartId',
          totalPrice: 1500,
          cartItems: [
            CartItemsDto(
              id: 'itemId1',
              product: ProductCartDto(
                id: 'prodId1',
                title: 'Rose Flower',
                description: 'Red Rose',
                price: 500,
              ),
              quantity: 2,
            ),
            CartItemsDto(
              id: 'itemId2',
              product: ProductCartDto(
                id: 'prodId2',
                title: 'Tulip',
                description: 'Yellow Tulip',
                price: 1000,
              ),
              quantity: 1,
            ),
          ],
        ),
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/cart/itemId'),
          statusCode: 200,
        ),
      );
      when(
        mockApiClient.deleteCartItem('itemId'),
      ).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.deleteCartItem(cartItemId: 'itemId')
              as SuccessApiResult<UserCartsDto>;

      expect(result, isA<SuccessApiResult<UserCartsDto>>());
      expect(result.data.error, fakeDto.error);
      expect(result.data.message, fakeDto.message);
      expect(result.data.numOfCartItems, fakeDto.numOfCartItems);
      verify(mockApiClient.deleteCartItem(any)).called(1);
    });
    test(
      'should return ApiError when delete cart item throws exception',
      () async {
        when(
          mockApiClient.deleteCartItem(any),
        ).thenThrow(Exception('Network error'));

        final result =
            await dataSource.deleteCartItem(cartItemId: 'itemId')
                as ErrorApiResult<UserCartsDto>;
        expect(result, isA<ErrorApiResult<UserCartsDto>>());
        expect(result.error.toString(), contains("Network error"));
        verify(mockApiClient.deleteCartItem(any)).called(1);
      },
    );
  });

  group("OrdersRemoteDatasourceImpl.updateCartItemQuantity()", () {
    test(
      'should return ApiSuccess when update cart item quantity succeeds',
      () async {
        final fakeDto = UserCartsDto(
          error: 'error',
          message: 'Success',
          numOfCartItems: 2,
          cart: CartDto(
            id: 'cartId',
            totalPrice: 1500,
            cartItems: [
              CartItemsDto(
                id: 'itemId1',
                product: ProductCartDto(
                  id: 'prodId1',
                  title: 'Rose Flower',
                  description: 'Red Rose',
                  price: 500,
                ),
                quantity: 2,
              ),
              CartItemsDto(
                id: 'itemId2',
                product: ProductCartDto(
                  id: 'prodId2',
                  title: 'Tulip',
                  description: 'Yellow Tulip',
                  price: 1000,
                ),
                quantity: 1,
              ),
            ],
          ),
        );
        final fakeResponse = HttpResponse(
          fakeDto,
          Response(
            requestOptions: RequestOptions(path: '/cart/itemId'),
            statusCode: 200,
          ),
        );
        when(
          mockApiClient.updateCartItemQuantity('itemId', {'quantity': 3}),
        ).thenAnswer((_) async => fakeResponse);

        final result =
            await dataSource.updateCartItemQuantity(
                  cartItemId: 'itemId',
                  quantity: 3,
                )
                as SuccessApiResult<UserCartsDto>;

        expect(result, isA<SuccessApiResult<UserCartsDto>>());
        expect(result.data.error, fakeDto.error);
        expect(result.data.message, fakeDto.message);
        expect(result.data.numOfCartItems, fakeDto.numOfCartItems);
        verify(mockApiClient.updateCartItemQuantity(any, any)).called(1);
      },
    );
    test(
      'should return ApiError when update cart item quantity throws exception',
      () async {
        when(
          mockApiClient.updateCartItemQuantity(any, any),
        ).thenThrow(Exception('Network error'));

        final result =
            await dataSource.updateCartItemQuantity(
                  cartItemId: 'itemId',
                  quantity: 3,
                )
                as ErrorApiResult<UserCartsDto>;
        expect(result, isA<ErrorApiResult<UserCartsDto>>());
        expect(result.error.toString(), contains("Network error"));
        verify(mockApiClient.updateCartItemQuantity(any, any)).called(1);
      },
    );
  });

  group("OrdersRemoteDatasourceImpl.checkoutOrder()", () {
    final paymentRequest = PaymentRequest(
      shippingAddress: ShippingAddress(
        street: "123 Street",
        phone: "0101010101",
        city: "Cairo",
        lat: "30.0",
        long: "31.0",
      ),
    );

    final paymentResponse = PaymentResponse(
      message: "Payment session created",
      session: Session(
        id: "sess_123",
        object: "checkout.session",
        amountSubtotal: 1000,
        amountTotal: 1200,
        currency: "usd",
        paymentStatus: "unpaid",
        paymentMethodTypes: ["card"],
        customerEmail: "test@example.com",
        successUrl: "https://example.com/success",
        cancelUrl: "https://example.com/cancel",
      ),
    );

    final fakeHttpResponse = HttpResponse(
      paymentResponse,
      Response(
        requestOptions: RequestOptions(path: '/checkout'),
        statusCode: 200,
      ),
    );

    test("should return ApiSuccess when checkoutOrder succeeds", () async {
      // Arrange
      when(
        mockApiClient.checkoutOrder(
          token: anyNamed('token'),
          returnUrl: anyNamed('returnUrl'),
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => fakeHttpResponse);

      // Act
      final result = await dataSource.payment(
        token: "Bearer token",
        returnUrl: "https://example.com/return",
        request: paymentRequest,
      );

      // Assert
      expect(result, isA<SuccessApiResult<PaymentResponse>>());
      final data = (result as SuccessApiResult<PaymentResponse>).data;
      expect(data.message, "Payment session created");
      expect(data.session?.id, "sess_123");
      expect(data.session?.paymentStatus, "unpaid");
    });

    test(
      "should return ApiError when checkoutOrder throws exception",
      () async {
        // Arrange
        when(
          mockApiClient.checkoutOrder(
            token: anyNamed('token'),
            returnUrl: anyNamed('returnUrl'),
            request: anyNamed('request'),
          ),
        ).thenThrow(Exception("Network error"));

        // Act
        final result = await dataSource.payment(
          token: "Bearer token",
          returnUrl: "https://example.com/return",
          request: paymentRequest,
        );

        // Assert
        expect(result, isA<ErrorApiResult<PaymentResponse>>());
        expect(
          (result as ErrorApiResult).error.toString(),
          contains("Network error"),
        );
      },
    );
  });
}
