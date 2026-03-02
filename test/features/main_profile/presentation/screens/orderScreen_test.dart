import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_state.dart';
import 'package:flower_shop/features/main_profile/presentation/screens/orderScreen.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/orderList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';

import 'orderScreen_test.mocks.dart';

@GenerateMocks([OrderCubit])
void main() {
  late MockOrderCubit mockOrderCubit;

  setUp(() {
    mockOrderCubit = MockOrderCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<OrderCubit>.value(
        value: mockOrderCubit,
        child: const Orderscreen(),
      ),
    );
  }

  group('OrderScreen Widget Tests', () {
    testWidgets('renders loading state when status is loading', (
      WidgetTester tester,
    ) async {
      when(
        mockOrderCubit.state,
      ).thenReturn(OrderState(orders: Resource.loading()));
      when(
        mockOrderCubit.stream,
      ).thenAnswer((_) => Stream.value(OrderState(orders: Resource.loading())));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders error message when status is error', (
      WidgetTester tester,
    ) async {
      const errorMessage = "Failed to fetch orders";

      when(
        mockOrderCubit.state,
      ).thenReturn(OrderState(orders: Resource.error(errorMessage)));
      when(mockOrderCubit.stream).thenAnswer(
        (_) => Stream.value(OrderState(orders: Resource.error(errorMessage))),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('renders TabBarView with OrdersList when status is success', (
      WidgetTester tester,
    ) async {
      final mockOrders = [
        Order(id: '1', isDelivered: false),
        Order(id: '2', isDelivered: true),
      ];
      final orderResponse = OrderResponse(orders: mockOrders);

      when(
        mockOrderCubit.state,
      ).thenReturn(OrderState(orders: Resource.success(orderResponse)));
      when(mockOrderCubit.stream).thenAnswer(
        (_) =>
            Stream.value(OrderState(orders: Resource.success(orderResponse))),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(OrdersList), findsWidgets);
    });

    testWidgets('switches between tabs', (WidgetTester tester) async {
      final mockOrders = [
        Order(id: '1', isDelivered: false),
        Order(id: '2', isDelivered: true),
      ];
      final orderResponse = OrderResponse(orders: mockOrders);

      when(
        mockOrderCubit.state,
      ).thenReturn(OrderState(orders: Resource.success(orderResponse)));
      when(mockOrderCubit.stream).thenAnswer(
        (_) =>
            Stream.value(OrderState(orders: Resource.success(orderResponse))),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text("active".tr()), findsOneWidget);

      await tester.tap(find.text("completed".tr()));
      await tester.pumpAndSettle();
    });
  });
}
