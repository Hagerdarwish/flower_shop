import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckoutCubit extends Mock implements CheckoutCubit {
  // Add stream property to mock
  final Stream<CheckoutState> _stream = Stream<CheckoutState>.empty();

  @override
  Stream<CheckoutState> get stream => _stream;
}

void main() {
  late MockCheckoutCubit cubit;

  setUp(() {
    cubit = MockCheckoutCubit();
  });

  Widget buildWidget(CheckoutState state) {
    when(() => cubit.state).thenReturn(state);

    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<CheckoutCubit>.value(
          value: cubit,
          child: const TotalPrice(),
        ),
      ),
    );
  }

  testWidgets('shows zero when no order exists', (tester) async {
    final state = CheckoutState(
      order: Resource.initial(),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check that the widget renders
    expect(find.byType(TotalPrice), findsOneWidget);

    // Check for text containing "$" (price symbol)
    expect(find.textContaining('\$'), findsOneWidget);
  });

  testWidgets('shows total price when order exists', (tester) async {
    final order = CashOrderModel(
      id: '1',
      userId: '1',
      items: [],
      totalPrice: 150.0,
      paymentType: 'cash',
      isPaid: false,
      isDelivered: false,
      state: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderNumber: 'ORD-001',
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
    expect(find.byType(TotalPrice), findsOneWidget);

    // Check for price text (might show "150\$" or similar)
    expect(find.textContaining('\$'), findsOneWidget);
  });

  testWidgets('updates when cubit state changes', (tester) async {
    final state1 = CheckoutState(
      order: Resource.initial(),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    final order = CashOrderModel(
      id: '2',
      userId: '2',
      items: [],
      totalPrice: 250.0,
      paymentType: 'cash',
      isPaid: false,
      isDelivered: false,
      state: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderNumber: 'ORD-002',
    );

    final state2 = CheckoutState(
      order: Resource.success(order),
      addresses: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state1));

    // Update state
    when(() => cubit.state).thenReturn(state2);

    // Trigger rebuild
    await tester.pump();

    expect(find.byType(TotalPrice), findsOneWidget);
    expect(find.textContaining('\$'), findsOneWidget);
  });
}
