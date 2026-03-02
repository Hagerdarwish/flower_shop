import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_orders_usecases.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_cubit_test.mocks.dart';

@GenerateMocks([GetOrdersUsecases, AuthStorage])
void main() {
  late OrderCubit cubit;
  late MockGetOrdersUsecases mockGetOrdersUsecases;
  late MockAuthStorage mockAuthStorage;

  setUp(() {
    mockGetOrdersUsecases = MockGetOrdersUsecases();
    mockAuthStorage = MockAuthStorage();
    cubit = OrderCubit(mockGetOrdersUsecases, mockAuthStorage);
  });

  tearDown(() {
    cubit.close();
  });

  const tToken = 'test_token';
  final tOrderResponse = OrderResponse(message: 'Success', orders: []);

  group('OrderCubit - GetOrdersEvent', () {
    blocTest<OrderCubit, OrderState>(
      'emits [loading, success] when data is fetched successfully',
      build: () {
        provideDummy<ApiResult<OrderResponse>>(
          SuccessApiResult(data: tOrderResponse),
        );
        when(mockAuthStorage.getToken()).thenAnswer((_) async => tToken);
        when(
          mockGetOrdersUsecases(token: 'Bearer $tToken'),
        ).thenAnswer((_) async => SuccessApiResult(data: tOrderResponse));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetOrdersEvent()),
      expect: () => [
        predicate<OrderState>((state) => state.orders.isLoading),
        predicate<OrderState>(
          (state) =>
              state.orders.isSuccess && state.orders.data == tOrderResponse,
        ),
      ],
    );

    blocTest<OrderCubit, OrderState>(
      'emits [loading, error] when token is missing',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetOrdersEvent()),
      expect: () => [
        predicate<OrderState>((state) => state.orders.isLoading),
        predicate<OrderState>(
          (state) =>
              state.orders.isError && state.orders.error == "Token not found",
        ),
      ],
    );

    blocTest<OrderCubit, OrderState>(
      'emits [loading, error] when use case returns error',
      build: () {
        provideDummy<ApiResult<OrderResponse>>(
          ErrorApiResult(error: 'Server Error'),
        );
        when(mockAuthStorage.getToken()).thenAnswer((_) async => tToken);
        when(
          mockGetOrdersUsecases(token: 'Bearer $tToken'),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Server Error'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetOrdersEvent()),
      expect: () => [
        predicate<OrderState>((state) => state.orders.isLoading),
        predicate<OrderState>(
          (state) =>
              state.orders.isError && state.orders.error == 'Server Error',
        ),
      ],
    );
  });
}
