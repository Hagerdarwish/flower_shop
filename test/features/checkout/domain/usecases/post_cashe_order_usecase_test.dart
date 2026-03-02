import 'package:flower_shop/features/checkout/domain/usecases/post_cashe_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';

// Import the correct mocks file for THIS test
import 'post_cashe_order_usecase_test.mocks.dart';

// Create dummy values at the top level
ApiResult<CashOrderModel> dummyCashOrderResult =
    SuccessApiResult<CashOrderModel>(
      data: CashOrderModel(
        id: 'dummy',
        userId: 'dummy',
        items: [],
        totalPrice: 0.0,
        paymentType: 'cash',
        isPaid: false,
        isDelivered: false,
        state: 'pending',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        orderNumber: 'dummy',
      ),
    );

@GenerateMocks([CheckoutRepo])
void main() {
  late MockCheckoutRepo mockRepo;
  late PostCasheOrderUsecase usecase;

  const token = 'Bearer test-token';

  // Provide dummy value BEFORE any tests run
  setUpAll(() {
    provideDummy<ApiResult<CashOrderModel>>(dummyCashOrderResult);
  });

  setUp(() {
    mockRepo = MockCheckoutRepo();
    usecase = PostCasheOrderUsecase(mockRepo);
  });

  group('PostCasheOrderUsecase', () {
    test(
      'returns SuccessApiResult<CashOrderModel> when repo succeeds',
      () async {
        // arrange
        final fakeOrder = CashOrderModel(
          id: 'order_1',
          userId: 'user_1',
          items: [],
          totalPrice: 100.0,
          paymentType: 'cash',
          isPaid: false,
          isDelivered: false,
          state: 'pending',
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          orderNumber: 'ORD-001',
        );

        when(
          mockRepo.postCashOrder(token),
        ).thenAnswer((_) async => SuccessApiResult(data: fakeOrder));

        // act
        final result = await usecase(token);

        // assert
        expect(result, isA<SuccessApiResult<CashOrderModel>>());

        final data = (result as SuccessApiResult<CashOrderModel>).data;
        expect(data.id, 'order_1');
        expect(data.paymentType, 'cash');

        verify(mockRepo.postCashOrder(token)).called(1);
        verifyNoMoreInteractions(mockRepo);
      },
    );

    test('returns ErrorApiResult when repo fails', () async {
      // arrange
      when(mockRepo.postCashOrder(token)).thenAnswer(
        (_) async => ErrorApiResult<CashOrderModel>(error: 'network error'),
      );

      // act
      final result = await usecase(token);

      // assert
      expect(result, isA<ErrorApiResult<CashOrderModel>>());
      expect((result as ErrorApiResult<CashOrderModel>).error, 'network error');

      verify(mockRepo.postCashOrder(token)).called(1);
    });
  });
}
