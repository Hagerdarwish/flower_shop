import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_cubit.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_intent.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_states.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/widgets/saved_address_item.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/widgets/saved_address_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([SavedAddressCubit])
import 'saved_address_view_body_test.mocks.dart';

void main() {
  group('SavedAddressViewBody Tests', () {
    late MockSavedAddressCubit mockCubit;

    final fakeAddress = AddressEntity(
      id: '1',
      street: 'Main Street',
      phone: '01000000000',
      city: 'Cairo',
      lat: '30.01',
      long: '31.02',
      username: 'Ali',
    );

    setUp(() {
      mockCubit = MockSavedAddressCubit();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<SavedAddressCubit>.value(
          value: mockCubit,
          child: const Scaffold(body: SavedAddressViewBody()),
        ),
      );
    }

    testWidgets('shows loading indicator when state is loading', (
      tester,
    ) async {
      when(
        mockCubit.state,
      ).thenReturn(SavedAddressStates(addressesResource: Resource.loading()));
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when state is error', (tester) async {
      final errorMessage = 'Failed to load addresses';
      when(mockCubit.state).thenReturn(
        SavedAddressStates(addressesResource: Resource.error(errorMessage)),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('shows no addresses message when list is empty', (
      tester,
    ) async {
      when(
        mockCubit.state,
      ).thenReturn(SavedAddressStates(addressesResource: Resource.success([])));
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('No saved addresses'), findsOneWidget);
    });

    testWidgets('shows list of addresses when state is success', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        SavedAddressStates(addressesResource: Resource.success([fakeAddress])),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SavedAddressItem), findsOneWidget);
      expect(find.text('Cairo'), findsOneWidget);
      expect(find.text('Main Street'), findsOneWidget);
    });

    testWidgets('calls delete intent when delete button is pressed', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        SavedAddressStates(addressesResource: Resource.success([fakeAddress])),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());

      final deleteButton = find.byIcon(Icons.delete_outline);
      await tester.tap(deleteButton);
      await tester.pump();

      verify(
        mockCubit.doIntent(DeleteAddressIntent(addressId: fakeAddress.id)),
      ).called(1);
    });
  });
}
