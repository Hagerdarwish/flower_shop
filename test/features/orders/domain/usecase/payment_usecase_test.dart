import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/domain/repos/orders_repo.dart';
import 'package:flower_shop/features/orders/domain/usecase/payment_usecase.dart';

import 'get_user_carts_usecase_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late MockOrdersRepo mockOrdersRepo;
  late PaymentUsecase usecase;

  final fakeResponse = PaymentResponse();

  provideDummy<ApiResult<PaymentResponse>>(
    SuccessApiResult<PaymentResponse>(data: fakeResponse),
  );

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    usecase = PaymentUsecase(mockOrdersRepo);
  });

  group('PaymentUsecase', () {
    test('returns SuccessApiResult when repo succeeds', () async {
      // arrange
      when(
        mockOrdersRepo.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          street: 'street',
          phone: '0100000000',
          city: 'Cairo',
          lat: '0',
          long: '0',
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult<PaymentResponse>(data: fakeResponse),
      );

      // act
      final result = await usecase.call(
        token: 'token',
        returnUrl: 'returnUrl',
        street: 'street',
        phone: '0100000000',
        city: 'Cairo',
        lat: '0',
        long: '0',
      );

      // assert
      expect(result, isA<SuccessApiResult<PaymentResponse>>());
      verify(
        mockOrdersRepo.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          street: 'street',
          phone: '0100000000',
          city: 'Cairo',
          lat: '0',
          long: '0',
        ),
      ).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      // arrange
      when(
        mockOrdersRepo.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          street: 'street',
          phone: '0100000000',
          city: 'Cairo',
          lat: '0',
          long: '0',
        ),
      ).thenAnswer(
        (_) async => ErrorApiResult<PaymentResponse>(error: 'error'),
      );

      // act
      final result = await usecase.call(
        token: 'token',
        returnUrl: 'returnUrl',
        street: 'street',
        phone: '0100000000',
        city: 'Cairo',
        lat: '0',
        long: '0',
      );

      // assert
      expect(result, isA<ErrorApiResult<PaymentResponse>>());
      verify(
        mockOrdersRepo.payment(
          token: 'token',
          returnUrl: 'returnUrl',
          street: 'street',
          phone: '0100000000',
          city: 'Cairo',
          lat: '0',
          long: '0',
        ),
      ).called(1);
    });
  });
}
