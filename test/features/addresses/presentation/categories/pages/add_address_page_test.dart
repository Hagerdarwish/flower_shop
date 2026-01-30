import 'package:flower_shop/app/core/widgets/custom_button.dart';
import 'package:flower_shop/app/core/values/user_error_mesagges.dart';
import 'package:flower_shop/features/addresses/presentation/categories/pages/add_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(home: AddAddressPage());
  }

  group('AddAddressPage Widget Tests', () {
    testWidgets('renders all essential components', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Address'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('Recipient name'), findsOneWidget);

      expect(find.byType(CustomButton), findsOneWidget);
      expect(find.text('Save address'), findsOneWidget);

      expect(find.byIcon(Icons.location_pin), findsOneWidget);
    });

    testWidgets('validation triggers for Phone number field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final phoneField = find.ancestor(
        of: find.text('Phone number'),
        matching: find.byType(TextFormField),
      );

      await tester.enterText(phoneField, '123');
      await tester.pump();

      expect(find.text(UserErrorMessages.invalidNumber), findsOneWidget);

      await tester.enterText(phoneField, '01012345678');
      await tester.pump();

      expect(find.text(UserErrorMessages.invalidNumber), findsNothing);
    });

    testWidgets('validation triggers for Recipient name field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final nameField = find.ancestor(
        of: find.text('Recipient name'),
        matching: find.byType(TextFormField),
      );

      await tester.enterText(nameField, 'A');
      await tester.pump();

      expect(find.text(UserErrorMessages.least3Characters), findsOneWidget);

      await tester.enterText(nameField, 'Valid Name');
      await tester.pump();

      expect(find.text(UserErrorMessages.least3Characters), findsNothing);
    });

    testWidgets('save button is initially disabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}
