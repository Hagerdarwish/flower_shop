import 'package:flower_shop/features/checkout/data/repos/checkout_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';

import 'checkout_repo_imp_test.mocks.dart';

@GenerateMocks([CheckoutDataSource])
void main() {
  late MockCheckoutDataSource mockDataSource;
  late CheckoutRepoImpl repo;

  const token = 'Bearer test-token';

  setUp(() {
    mockDataSource = MockCheckoutDataSource();
    repo = CheckoutRepoImpl(checkoutDataSource: mockDataSource);
  });

  group('CheckoutRepoImpl.postCashOrder', () {
    test(
      'returns SuccessApiResult<CashOrderModel> when datasource succeeds',
      () async {
        // arrange
        final fakeResponse = CashOrderResponse(
          message: 'success',
          order: Order(
            id: 'order_1',
            user: 'user_1',
            totalPrice: 100,
            paymentType: 'cash',
            isPaid: false,
            isDelivered: false,
            state: 'pending',
            createdAt: DateTime(2024, 1, 1),
            updatedAt: DateTime(2024, 1, 1),
            orderNumber: 'ORD-001',
            v: 0,
            orderItems: [],
          ),
        );

        when(
          mockDataSource.cashOrder(token),
        ).thenAnswer((_) async => SuccessApiResult(data: fakeResponse));

        // act
        final result = await repo.postCashOrder(token);

        // assert
        expect(result, isA<SuccessApiResult<CashOrderModel>>());

        final data = (result as SuccessApiResult<CashOrderModel>).data;
        expect(data.id, 'order_1');
        expect(data.paymentType, 'cash');

        verify(mockDataSource.cashOrder(token)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('returns ErrorApiResult when datasource fails', () async {
      // arrange
      when(
        mockDataSource.cashOrder(token),
      ).thenAnswer((_) async => ErrorApiResult(error: 'network error'));

      // act
      final result = await repo.postCashOrder(token);

      // assert
      expect(result, isA<ErrorApiResult<CashOrderModel>>());
      expect((result as ErrorApiResult).error, 'network error');

      verify(mockDataSource.cashOrder(token)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('CheckoutRepoImpl.getAddress', () {
    test(
      'returns SuccessApiResult<List<AddressModel>> when datasource succeeds',
      () async {
        // arrange
        final fakeResponse = AddressCheckOutResponse(
          message: 'success',
          addresses: [],
        );

        when(
          mockDataSource.getAddress(token),
        ).thenAnswer((_) async => SuccessApiResult(data: fakeResponse));

        // act
        final result = await repo.getAddress(token);

        // assert
        expect(result, isA<SuccessApiResult<List<AddressModel>>>());
        expect(
          (result as SuccessApiResult<List<AddressModel>>).data,
          isA<List<AddressModel>>(),
        );

        verify(mockDataSource.getAddress(token)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('returns ErrorApiResult when datasource fails', () async {
      // arrange
      when(
        mockDataSource.getAddress(token),
      ).thenAnswer((_) async => ErrorApiResult(error: 'unauthorized'));

      // act
      final result = await repo.getAddress(token);

      // assert
      expect(result, isA<ErrorApiResult<List<AddressModel>>>());
      expect((result as ErrorApiResult).error, 'unauthorized');

      verify(mockDataSource.getAddress(token)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
