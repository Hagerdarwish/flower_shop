import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/domain/usecase/payment_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';

import 'payment_cubit_test.mocks.dart';

// Generate mocks for both dependencies
@GenerateMocks([PaymentUsecase, AuthStorage])
void main() {
  late MockPaymentUsecase mockPaymentUsecase;
  late MockAuthStorage mockAuthStorage;
  late PaymentCubit cubit;

  final fakeResponse = PaymentResponse();

  setUpAll(() {
    provideDummy<ApiResult<PaymentResponse>>(
      SuccessApiResult<PaymentResponse>(data: PaymentResponse()),
    );
  });

  setUp(() {
    mockPaymentUsecase = MockPaymentUsecase();
    mockAuthStorage = MockAuthStorage();

    // Mock the token retrieval
    when(mockAuthStorage.getToken()).thenAnswer((_) async => 'token');

    cubit = PaymentCubit(mockPaymentUsecase, mockAuthStorage);
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
        // First state: loading with executing action
        isA<PaymentStates>()
            .having((s) => s.lastAction, 'lastAction', PaymentAction.executing)
            .having((s) => s.paymentResponse?.status, 'status', Status.loading),
        // Second state: success with action reset to none
        isA<PaymentStates>()
            .having(
              (s) => s.lastAction,
              'lastAction',
              PaymentAction.none, // Reset after completion
            )
            .having((s) => s.paymentResponse?.status, 'status', Status.success),
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
        // First state: loading with executing action
        isA<PaymentStates>()
            .having((s) => s.lastAction, 'lastAction', PaymentAction.executing)
            .having((s) => s.paymentResponse?.status, 'status', Status.loading),
        // Second state: error with action reset to none
        isA<PaymentStates>()
            .having(
              (s) => s.lastAction,
              'lastAction',
              PaymentAction.none, // Reset after completion
            )
            .having((s) => s.paymentResponse?.status, 'status', Status.error)
            .having((s) => s.paymentResponse?.error, 'error', 'error'),
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
      },
    );
  });

  test('resetAction sets lastAction to none', () {
    cubit.resetAction();
    expect(cubit.state.lastAction, PaymentAction.none);
  });
}
