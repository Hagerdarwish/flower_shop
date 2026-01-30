/*import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/screens/checkout_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_checkout_cubit.dart';

void main() {
  late MockCheckoutCubit cubit;

  setUp(() {
    cubit = MockCheckoutCubit();
  });

  testWidgets('Shows loading indicator when addresses are loading',
      (tester) async {
    when(() => cubit.state).thenReturn(
      CheckoutState(
        addresses: Resource.loading(),
        paymentMethod: PaymentMethod.cash,
        order: Resource.initial(),
        isLoading: false,
        error: null,
        selectedAddress: null,
      ),
    );

    await tester.pumpWidget(
      BlocProvider<CheckoutCubit>(
        create: (context) => cubit,
        child: const MaterialApp(
          home: Scaffold(body: CheckoutBody()),
        ),
      ),
    );

    // Use pump() instead of pumpAndSettle()
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Shows empty state when no addresses found', (tester) async {
    when(() => cubit.state).thenReturn(
      CheckoutState(
        addresses: Resource.success([]),
        paymentMethod: PaymentMethod.cash,
        order: Resource.initial(),
        isLoading: false,
        error: null,
        selectedAddress: null,
      ),
    );

    await tester.pumpWidget(
      BlocProvider<CheckoutCubit>(
        create: (context) => cubit,
        child: const MaterialApp(
          home: Scaffold(body: CheckoutBody()),
        ),
      ),
    );

    // Use pump() instead of pumpAndSettle()
    await tester.pump();

    // Look for any text that might appear in empty state
    // This could be "No addresses", "Add address", empty icon, etc.
    final emptyStateFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          (widget.data?.contains('No') == true ||
              widget.data?.contains('Add') == true ||
              widget.data?.contains('address') == true),
    );

    expect(emptyStateFinder, findsOneWidget);
  });
}*/
