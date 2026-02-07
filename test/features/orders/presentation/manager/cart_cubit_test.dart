import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/usecase/add_product_to_cart_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/delete_cart_item_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/get_user_carts_usecase.dart';
import 'package:flower_shop/features/orders/domain/usecase/update_cart_item_quantity_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserCartsUsecase,
  AddProductToCartUsecase,
  DeleteCartItemUsecase,
  UpdateCartItemQuantityUsecase,
])
void main() {
  late MockGetUserCartsUsecase mockGetUserCartsUsecase;
  late MockAddProductToCartUsecase mockAddProductToCartUsecase;
  late MockDeleteCartItemUsecase mockDeleteCartItemUsecase;
  late MockUpdateCartItemQuantityUsecase mockUpdateCartItemQuantityUsecase;
  late CartCubit cubit;
  final fakeData = UserCartsModel(
    error: 'error',
    message: 'Success',
    numOfCartItems: 2,
    cart: CartModel(
      id: 'cartId',
      totalPrice: 1500,
      cartItems: [
        CartItemsModel(
          id: 'itemId1',
          price: 500,
          product: ProductCartModel(
            id: 'prodId1',
            title: 'Rose Flower',
            description: 'Red Rose',
            price: 500,
          ),
          quantity: 2,
        ),
      ],
    ),
  );
  setUpAll(() {
    mockGetUserCartsUsecase = MockGetUserCartsUsecase();
    mockAddProductToCartUsecase = MockAddProductToCartUsecase();
    mockDeleteCartItemUsecase = MockDeleteCartItemUsecase();
    mockUpdateCartItemQuantityUsecase = MockUpdateCartItemQuantityUsecase();
    provideDummy<ApiResult<UserCartsModel>>(
      SuccessApiResult<UserCartsModel>(data: UserCartsModel()),
    );
  });
  setUp(() {
    cubit = CartCubit(
      mockGetUserCartsUsecase,
      mockAddProductToCartUsecase,
      mockDeleteCartItemUsecase,
      mockUpdateCartItemQuantityUsecase,
    );
  });
  tearDown(() async {
    await cubit.close();
  });

  group('Get All Carts', () {
    blocTest(
      'emit loading, success when GetAllCartsIntent success',
      build: () {
        when(mockGetUserCartsUsecase.call()).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(GetAllCartsIntent());
      },

      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        expect(
          cubit.cartsList.first.price,
          fakeData.cart?.cartItems?.first?.price,
        );
        expect(cubit.cartsList.length, 1);
        expect(cubit.state.cart?.data?.cart?.cartItems?.first?.id, 'itemId1');
        verify(mockGetUserCartsUsecase.call()).called(1);
      },
    );

    blocTest(
      'emits loading, error when GetAllCartsIntent fails',
      build: () {
        when(mockGetUserCartsUsecase.call()).thenAnswer(
          (_) async => ErrorApiResult<UserCartsModel>(error: 'error'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAllCartsIntent()),
      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having((s) => s.cart?.status, 'status', Status.error),
      ],
      verify: (_) {
        expect(cubit.state.cart?.error, 'error');
        verify(mockGetUserCartsUsecase.call()).called(1);
      },
    );
  });

  group('Add Product To Cart', () {
    blocTest(
      'emit loading, success when AddProductToCartIntent success',
      build: () {
        when(
          mockAddProductToCartUsecase.call(product: 'product1', quantity: 1),
        ).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(
          AddProductToCartIntent(productId: 'product1', quantity: 1),
        );
      },

      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        expect(
          cubit.cartsList.first.price,
          fakeData.cart?.cartItems?.first?.price,
        );
        expect(cubit.cartsList.length, 1);
        expect(cubit.state.cart?.data?.cart?.cartItems?.first?.id, 'itemId1');
        verify(
          mockAddProductToCartUsecase.call(product: 'product1', quantity: 1),
        ).called(1);
      },
    );

    blocTest(
      'emits loading, error when AddProductToCartIntent fails',
      build: () {
        when(
          mockAddProductToCartUsecase.call(product: 'product1', quantity: 1),
        ).thenAnswer(
          (_) async => ErrorApiResult<UserCartsModel>(error: 'error'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        AddProductToCartIntent(productId: 'product1', quantity: 1),
      ),
      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having((s) => s.cart?.status, 'status', Status.error),
      ],
      verify: (_) {
        expect(cubit.state.cart?.error, 'error');
        verify(
          mockAddProductToCartUsecase.call(product: 'product1', quantity: 1),
        ).called(1);
      },
    );
  });

  group('Delete Cart Item', () {
    blocTest(
      'emit loading, success when DeleteCartItemIntent success',
      build: () {
        when(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(DeleteCartItemIntent(cartItemId: 'itemId1'));
      },

      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        expect(
          cubit.cartsList.first.price,
          fakeData.cart?.cartItems?.first?.price,
        );
        expect(cubit.cartsList.length, 1);
        expect(cubit.state.cart?.data?.cart?.cartItems?.first?.id, 'itemId1');
        verify(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).called(1);
      },
    );

    blocTest(
      'emits loading, error when DeleteCartItemIntent fails',
      build: () {
        when(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).thenAnswer(
          (_) async => ErrorApiResult<UserCartsModel>(error: 'error'),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doIntent(DeleteCartItemIntent(cartItemId: 'itemId1')),
      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having((s) => s.cart?.status, 'status', Status.error),
      ],
      verify: (_) {
        expect(cubit.state.cart?.error, 'error');
        verify(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).called(1);
      },
    );
  });

  group('Update Cart Item Quantity', () {
    blocTest(
      'emit loading, success when UpdateCartItemQuantityIntent success',
      build: () {
        when(
          mockUpdateCartItemQuantityUsecase.call(
            cartItemId: 'itemId1',
            quantity: 3,
          ),
        ).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(
          UpdateCartItemQuantityIntent(
            cartItemId: 'itemId1',
            quantity: 2,
            increase: true,
          ),
        );
      },

      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        verify(
          mockUpdateCartItemQuantityUsecase.call(
            cartItemId: 'itemId1',
            quantity: 3,
          ),
        ).called(1);
      },
    );

    blocTest(
      'calls delete method when decreasing quantity from 1',
      build: () {
        when(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        UpdateCartItemQuantityIntent(
          cartItemId: 'itemId1',
          quantity: 1,
          increase: false,
        ),
      ),
      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.loading,
        ),
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'status',
          Status.success,
        ),
      ],
      verify: (_) {
        verify(mockDeleteCartItemUsecase.call(cartItemId: 'itemId1')).called(1);
      },
    );

    blocTest(
      'emits loading, error when UpdateCartItemQuantityIntent fails',
      build: () {
        when(
          mockUpdateCartItemQuantityUsecase.call(
            cartItemId: 'itemId1',
            quantity: 1,
          ),
        ).thenAnswer(
          (_) async => ErrorApiResult<UserCartsModel>(error: 'error'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        UpdateCartItemQuantityIntent(
          cartItemId: 'itemId1',
          quantity: 2,
          increase: false,
        ),
      ),
      expect: () => [
        isA<CartStates>().having(
          (s) => s.cart?.status,
          'loading',
          Status.loading,
        ),
        isA<CartStates>().having((s) => s.cart?.status, 'error', Status.error),
      ],
      verify: (_) {
        verify(
          mockUpdateCartItemQuantityUsecase.call(
            cartItemId: 'itemId1',
            quantity: 1,
          ),
        ).called(1);
      },
    );
  });
}
