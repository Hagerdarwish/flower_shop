import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckoutCubit extends Mock implements CheckoutCubit {
  // Provide a mock stream
  final Stream<CheckoutState> _stream = Stream<CheckoutState>.empty();

  @override
  Stream<CheckoutState> get stream => _stream;
}

// Create fake classes for CheckoutIntents
class GetAddressIntentFake extends Fake implements GetAddressIntent {}

class CashOrderIntentFake extends Fake implements CashOrderIntent {}

class PlaceOrderIntentFake extends Fake implements PlaceOrderIntent {}

class SelectAddressIntentFake extends Fake implements SelectAddressIntent {}

void main() {
  late MockCheckoutCubit cubit;

  final addresses = [
    AddressModel(
      id: '1',
      username: 'Rahma',
      street: 'Main Street',
      city: 'Cairo',
      lat: 1.0,
      long: 1.0,
      phone: '1',
    ),
    AddressModel(
      id: '2',
      username: 'Sara',
      street: 'Green Ave',
      city: 'Giza',
      lat: 2.0,
      long: 2.0,
      phone: '2',
    ),
  ];

  // Register fallback values before tests
  setUpAll(() {
    registerFallbackValue(GetAddressIntentFake());
    registerFallbackValue(CashOrderIntentFake());
    registerFallbackValue(PlaceOrderIntentFake());
    registerFallbackValue(SelectAddressIntentFake());
  });

  setUp(() {
    cubit = MockCheckoutCubit();
    when(() => cubit.doIntent(any())).thenReturn(null);
    when(() => cubit.state).thenReturn(
      CheckoutState(
        addresses: Resource.success(addresses),
        selectedAddress: addresses.first,
        paymentMethod: PaymentMethod.cash,
        order: Resource.initial(),
        isLoading: false,
        error: null,
      ),
    );
  });

  testWidgets('renders addresses and allows selection', (tester) async {
    final state = CheckoutState(
      addresses: Resource.success(addresses),
      selectedAddress: addresses.first,
      paymentMethod: PaymentMethod.cash,
      order: Resource.initial(),
      isLoading: false,
      error: null,
    );

    when(() => cubit.state).thenReturn(state);

    await tester.pumpWidget(
      BlocProvider<CheckoutCubit>.value(
        value: cubit,
        child: MaterialApp(
          home: Scaffold(body: AddressSection(state: state)),
        ),
      ),
    );

    // Check if addresses are rendered
    expect(find.text('Rahma'), findsOneWidget);
    expect(find.text('Sara'), findsOneWidget);

    // Tap second address
    await tester.tap(find.text('Sara'));
    await tester.pump();

    verify(
      () => cubit.doIntent(any(that: isA<SelectAddressIntent>())),
    ).called(1);
  });
}
