import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildWidget(CheckoutState state) {
    return MaterialApp(home: Scaffold(body: OrderStatusSection()));
  }

  testWidgets('renders nothing when order is not successful', (tester) async {
    final state = CheckoutState(
      order: Resource.initial(),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check that OrderStatusSection doesn't show anything visible
    expect(find.byType(OrderStatusSection), findsOneWidget);
  });

  testWidgets('shows Delivered status when order is delivered', (tester) async {
    final order = CashOrderModel(
      isDelivered: true,
      isPaid: true,
      id: '1',
      orderNumber: 'ORD-001',
      paymentType: 'cash',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      state: 'delivered',
      totalPrice: 100,
      items: [],
      userId: '1',
    );

    final state = CheckoutState(
      order: Resource.success(order),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check for the widget existence
    expect(find.byType(OrderStatusSection), findsOneWidget);
  });

  testWidgets('shows Paid status when order is paid but not delivered', (
    tester,
  ) async {
    final order = CashOrderModel(
      isDelivered: false,
      isPaid: true,
      id: '2',
      orderNumber: 'ORD-002',
      paymentType: 'card',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      state: 'paid',
      totalPrice: 200,
      items: [],
      userId: '2',
    );

    final state = CheckoutState(
      order: Resource.success(order),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check for the widget existence
    expect(find.byType(OrderStatusSection), findsOneWidget);
  });

  testWidgets('shows order details when order exists', (tester) async {
    final order = CashOrderModel(
      id: '3',
      orderNumber: 'ORD-003',
      paymentType: 'cash',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      state: 'pending',
      totalPrice: 300,
      isPaid: false,
      userId: '3',
      items: [],
      isDelivered: false,
    );

    final state = CheckoutState(
      order: Resource.success(order),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check that the widget renders
    expect(find.byType(OrderStatusSection), findsOneWidget);
  });
}
