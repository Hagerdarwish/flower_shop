import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/domain/usecase/payment_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';

import 'payment_cubit_test.mocks.dart';

@GenerateMocks([PaymentUsecase])
void main() {
  late MockPaymentUsecase mockPaymentUsecase;
  late PaymentCubit cubit;

  final fakeResponse = PaymentResponse(); // عدل لو ليه constructor

  setUpAll(() {
    mockPaymentUsecase = MockPaymentUsecase();

    provideDummy<ApiResult<PaymentResponse>>(
      SuccessApiResult<PaymentResponse>(data: PaymentResponse()),
    );
  });

  setUp(() {
    cubit = PaymentCubit(mockPaymentUsecase);
  });

  tearDown(() async {
    await cubit.close();
  });

  final intent = ExecutePaymentIntent(
    token: 'token',
    returnUrl: 'returnUrl',
    street: 'street',
    phone: '0100000000',
    city: 'Cairo',
    lat: '0',
    long: '0',
  );

  group('Execute Payment', () {
    blocTest<PaymentCubit, PaymentStates>(
      'emit loading, success when ExecutePaymentIntent success',
      build: () {
        when(
          mockPaymentUsecase.call(
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
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent),
      expect: () => [
        isA<PaymentStates>().having(
          (s) => s.paymentResponse?.status,
          'status',
          Status.loading,
        ),
        isA<PaymentStates>().having(
          (s) => s.paymentResponse?.status,
          'status',
          Status.success,
        ),
      ],
      verify: (_) {
        verify(
          mockPaymentUsecase.call(
            token: 'token',
            returnUrl: 'returnUrl',
            street: 'street',
            phone: '0100000000',
            city: 'Cairo',
            lat: '0',
            long: '0',
          ),
        ).called(1);

        expect(cubit.state.lastAction, PaymentAction.executing);
      },
    );

    blocTest<PaymentCubit, PaymentStates>(
      'emit loading, error when ExecutePaymentIntent fails',
      build: () {
        when(
          mockPaymentUsecase.call(
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
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent),
      expect: () => [
        isA<PaymentStates>().having(
          (s) => s.paymentResponse?.status,
          'status',
          Status.loading,
        ),
        isA<PaymentStates>().having(
          (s) => s.paymentResponse?.status,
          'status',
          Status.error,
        ),
      ],
      verify: (_) {
        expect(cubit.state.paymentResponse?.error, 'error');
        verify(
          mockPaymentUsecase.call(
            token: 'token',
            returnUrl: 'returnUrl',
            street: 'street',
            phone: '0100000000',
            city: 'Cairo',
            lat: '0',
            long: '0',
          ),
        ).called(1);
      },
    );
  });

  test('resetAction sets lastAction to none', () {
    cubit.resetAction();
    expect(cubit.state.lastAction, PaymentAction.none);
  });
}
