import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/payment.dart';
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

// Create fake classes for CheckoutIntents
class GetAddressIntentFake extends Fake implements GetAddressIntent {}

class CashOrderIntentFake extends Fake implements CashOrderIntent {}

class PlaceOrderIntentFake extends Fake implements PlaceOrderIntent {}

class SelectAddressIntentFake extends Fake implements SelectAddressIntent {}

class ChangePaymentMethodIntentFake extends Fake
    implements ChangePaymentMethodIntent {}

void main() {
  late MockCheckoutCubit cubit;

  // Register fallback values before tests
  setUpAll(() {
    registerFallbackValue(GetAddressIntentFake());
    registerFallbackValue(CashOrderIntentFake());
    registerFallbackValue(PlaceOrderIntentFake());
    registerFallbackValue(SelectAddressIntentFake());
    registerFallbackValue(ChangePaymentMethodIntentFake());
  });

  setUp(() {
    cubit = MockCheckoutCubit();
    when(() => cubit.doIntent(any())).thenReturn(null);
    // Mock the state as well
    when(() => cubit.state).thenReturn(
      CheckoutState(
        paymentMethod: PaymentMethod.cash,
        addresses: Resource.initial(),
        order: Resource.initial(),
        isLoading: false,
        error: null,
        selectedAddress: null,
      ),
    );
  });

  Widget buildWidget(CheckoutState state) {
    return BlocProvider<CheckoutCubit>.value(
      value: cubit,
      child: MaterialApp(
        home: Scaffold(body: PaymentMethodSection(checkoutState: state)),
      ),
    );
  }

  testWidgets('renders payment methods correctly', (tester) async {
    final state = CheckoutState(
      paymentMethod: PaymentMethod.cash,
      addresses: Resource.initial(),
      order: Resource.initial(),
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    // Check for RadioListTile widgets
    expect(find.byType(RadioListTile<PaymentMethod>), findsNWidgets(2));
  });

  testWidgets('selecting cash triggers ChangePaymentMethodIntent', (
    tester,
  ) async {
    final state = CheckoutState(
      paymentMethod: PaymentMethod.card,
      addresses: Resource.initial(),
      order: Resource.initial(),
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    // Update mocked state
    when(() => cubit.state).thenReturn(state);

    await tester.pumpWidget(buildWidget(state));

    // Find and tap cash radio button
    final cashRadio = find.byWidgetPredicate(
      (widget) =>
          widget is RadioListTile<PaymentMethod> &&
          widget.value == PaymentMethod.cash,
    );
    await tester.tap(cashRadio);
    await tester.pump();

    verify(
      () => cubit.doIntent(any(that: isA<ChangePaymentMethodIntent>())),
    ).called(1);
  });

  testWidgets('selecting card triggers ChangePaymentMethodIntent', (
    tester,
  ) async {
    final state = CheckoutState(
      paymentMethod: PaymentMethod.cash,
      addresses: Resource.initial(),
      order: Resource.initial(),
      isLoading: false,
      error: null,
      selectedAddress: null,
    );

    // Update mocked state
    when(() => cubit.state).thenReturn(state);

    await tester.pumpWidget(buildWidget(state));

    // Find and tap card radio button
    final cardRadio = find.byWidgetPredicate(
      (widget) =>
          widget is RadioListTile<PaymentMethod> &&
          widget.value == PaymentMethod.card,
    );
    await tester.tap(cardRadio);
    await tester.pump();

    verify(
      () => cubit.doIntent(any(that: isA<ChangePaymentMethodIntent>())),
    ).called(1);
  });
}
