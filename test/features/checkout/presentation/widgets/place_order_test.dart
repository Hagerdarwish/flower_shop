/*import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/place_order.dart';
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
class ChangePaymentMethodIntentFake extends Fake implements ChangePaymentMethodIntent {}

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
  });

  Widget buildWidget(CheckoutState state) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<CheckoutCubit>.value(
          value: cubit,
          child: PlaceOrderButton(state: state),
        ),
      ),
    );
  }

  testWidgets('button is disabled when isLoading is true', (tester) async {
    final state = CheckoutState(
      isLoading: true,
      addresses: Resource.initial(),
      order: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('button is disabled when no address is selected', (tester) async {
    final state = CheckoutState(
      isLoading: false,
      addresses: Resource.initial(),
      order: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      error: null,
      selectedAddress: null,
    );

    await tester.pumpWidget(buildWidget(state));

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('button is enabled and triggers CashOrderIntent when tapped',
      (tester) async {
    final state = CheckoutState(
      isLoading: false,
      addresses: Resource.initial(),
      order: Resource.initial(),
      paymentMethod: PaymentMethod.cash,
      error: null,
      selectedAddress: AddressModel(
        id: '1',
        username: 'Test',
        street: 'Street',
        city: 'City',
        lat: 1.0,
        long: 1.0,
        phone: '123',
      ),
    );

    await tester.pumpWidget(buildWidget(state));

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(
      () => cubit.doIntent(
        any(that: isA<CashOrderIntent>()),
      ),
    ).called(1);
  });
}*/
