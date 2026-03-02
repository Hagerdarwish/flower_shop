import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/usecase/delete_cart_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_user_carts_usecase_test.mocks.dart';

void main() {
  late MockOrdersRepo mockRepo;
  late DeleteCartItemUsecase usecase;

  setUpAll(() {
    mockRepo = MockOrdersRepo();
    usecase = DeleteCartItemUsecase(mockRepo);
    provideDummy<ApiResult<UserCartsModel>>(
      SuccessApiResult<UserCartsModel>(data: UserCartsModel()),
    );
  });
  group('Delete cart item use case', () {
    test(
      'return ApiSuccess when repo return delete cart item success',
      () async {
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

        when(mockRepo.deleteCartItem(cartItemId: 'itemId1')).thenAnswer(
          (_) async => SuccessApiResult<UserCartsModel>(data: fakeData),
        );

        final result =
            await usecase.call(cartItemId: 'itemId1')
                as SuccessApiResult<UserCartsModel>;

        expect(result, isA<SuccessApiResult<UserCartsModel>>());
        expect(result.data.message, fakeData.message);
        expect(result.data.numOfCartItems, fakeData.numOfCartItems);
        expect(result.data.cart?.totalPrice, fakeData.cart?.totalPrice);
        expect(
          result.data.cart?.cartItems?.first?.product?.title,
          fakeData.cart?.cartItems?.first?.product?.title,
        );
        verify(mockRepo.deleteCartItem(cartItemId: 'itemId1')).called(1);
      },
    );

    test('return ApiError when repo return delete cart item fail', () async {
      when(mockRepo.deleteCartItem(cartItemId: 'itemId1')).thenAnswer(
        (_) async =>
            ErrorApiResult<UserCartsModel>(error: 'Something went wrong'),
      );

      final result =
          await usecase.call(cartItemId: 'itemId1')
              as ErrorApiResult<UserCartsModel>;

      expect(result, isA<ErrorApiResult<UserCartsModel>>());
      expect(result.error, 'Something went wrong');
      verify(mockRepo.deleteCartItem(cartItemId: 'itemId1')).called(1);
    });
  });
}
