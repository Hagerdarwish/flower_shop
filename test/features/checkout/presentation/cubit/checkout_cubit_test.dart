import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_addresss_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/post_cashe_order_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';

import 'checkout_cubit_test.mocks.dart';

ApiResult<List<AddressModel>> dummyAddressResult =
    SuccessApiResult<List<AddressModel>>(data: []);

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

@GenerateMocks([GetAddressUsecase, PostCasheOrderUsecase, AuthStorage])
void main() {
  late MockGetAddressUsecase mockGetAddressUsecase;
  late MockPostCasheOrderUsecase mockPostOrderUsecase;
  late MockAuthStorage mockAuthStorage;
  late CheckoutCubit cubit;

  // Provide dummy values BEFORE setup
  setUpAll(() {
    provideDummy<ApiResult<List<AddressModel>>>(dummyAddressResult);
    provideDummy<ApiResult<CashOrderModel>>(dummyCashOrderResult);
  });

  setUp(() {
    mockGetAddressUsecase = MockGetAddressUsecase();
    mockPostOrderUsecase = MockPostCasheOrderUsecase();
    mockAuthStorage = MockAuthStorage();

    cubit = CheckoutCubit(
      mockPostOrderUsecase,
      mockGetAddressUsecase,
      mockAuthStorage,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('CheckoutCubit - GetAddressIntent', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then success when address loaded successfully',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => 'token');

        when(mockGetAddressUsecase('Bearer token')).thenAnswer(
          (_) async => SuccessApiResult(
            data: [
              AddressModel(
                id: '1',
                username: 'Rahma',
                phone: '010',
                city: 'Cairo',
                street: 'Nasr City',
                lat: 30,
                long: 31,
              ),
            ],
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAddressIntent()),
      expect: () => [
        // First state: loading
        isA<CheckoutState>().having(
          (s) => s.addresses.isLoading,
          'addresses.isLoading',
          true,
        ),
        // Second state: success with data
        isA<CheckoutState>()
            .having((s) => s.addresses.isSuccess, 'addresses.isSuccess', true)
            .having((s) => s.addresses.data, 'addresses.data', [
              isA<AddressModel>().having((a) => a.id, 'id', '1'),
            ]),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits error when token is null',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAddressIntent()),
      expect: () => [
        // First state: loading
        isA<CheckoutState>().having(
          (s) => s.addresses.isLoading,
          'addresses.isLoading',
          true,
        ),
        // Second state: error
        isA<CheckoutState>()
            .having((s) => s.addresses.isError, 'addresses.isError', true)
            .having(
              (s) => s.addresses.error,
              'addresses.error',
              'Token not found',
            ),
      ],
    );
  });

  group('CheckoutCubit - CashOrderIntent', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits loading then success when cash order succeeds',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => 'token');

        when(mockPostOrderUsecase('Bearer token')).thenAnswer(
          (_) async => SuccessApiResult(
            data: CashOrderModel(
              id: 'order_1',
              userId: 'user_1',
              items: [],
              totalPrice: 100,
              paymentType: 'cash',
              isPaid: false,
              isDelivered: false,
              state: 'pending',
              createdAt: DateTime(2024, 1, 1),
              updatedAt: DateTime(2024, 1, 1),
              orderNumber: 'ORD-1',
            ),
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.doIntent(CashOrderIntent()),
      expect: () => [
        // First state: loading
        isA<CheckoutState>().having((s) => s.isLoading, 'isLoading', true),
        // Second state: success
        isA<CheckoutState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.order.isSuccess, 'order.isSuccess', true)
            .having((s) => s.order.data?.id, 'order.data.id', 'order_1'),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits error when cash order fails',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => 'token');

        when(mockPostOrderUsecase('Bearer token')).thenAnswer(
          (_) async => ErrorApiResult<CashOrderModel>(error: 'network error'),
        );

        return cubit;
      },
      act: (cubit) => cubit.doIntent(CashOrderIntent()),
      expect: () => [
        // First state: loading
        isA<CheckoutState>().having((s) => s.isLoading, 'isLoading', true),
        // Second state: error
        isA<CheckoutState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.error, 'error', 'network error')
            .having((s) => s.order.isError, 'order.isError', true)
            .having((s) => s.order.error, 'order.error', 'network error'),
      ],
    );
  });

  group('CheckoutCubit - PlaceOrderIntent', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits error when payment method is not selected',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(PlaceOrderIntent()),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.error,
          'error',
          'Please select payment method',
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'triggers cash order when payment method is cash',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => 'token');

        when(mockPostOrderUsecase('Bearer token')).thenAnswer(
          (_) async => SuccessApiResult(
            data: CashOrderModel(
              id: '1',
              userId: '1',
              items: [],
              totalPrice: 10,
              paymentType: 'cash',
              isPaid: false,
              isDelivered: false,
              state: 'pending',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              orderNumber: 'ORD',
            ),
          ),
        );

        return cubit;
      },
      seed: () => CheckoutState(
        addresses: Resource.initial(),
        paymentMethod: PaymentMethod.cash,
        selectedAddress: null,
        order: Resource.initial(),
        isLoading: false,
        error: null,
      ),
      act: (cubit) => cubit.doIntent(PlaceOrderIntent()),
      expect: () => [
        isA<CheckoutState>().having((s) => s.isLoading, 'isLoading', true),
        isA<CheckoutState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.order.isSuccess, 'order.isSuccess', true)
            .having((s) => s.order.data?.id, 'order.data.id', '1'),
      ],
    );
  });
}
