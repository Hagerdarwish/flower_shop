import 'package:flower_shop/features/checkout/presentation/widgets/gifts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCallback extends Mock {
  void call(dynamic value);
}

void main() {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  late MockCallback onToggle;
  late MockCallback onNameChanged;
  late MockCallback onPhoneChanged;

  setUp(() {
    nameController = TextEditingController();
    phoneController = TextEditingController();

    onToggle = MockCallback();
    onNameChanged = MockCallback();
    onPhoneChanged = MockCallback();
  });

  tearDown(() {
    nameController.dispose();
    phoneController.dispose();
  });

  Widget buildWidget({required bool isGift}) {
    return MaterialApp(
      home: Scaffold(
        body: GiftSection(
          isGift: isGift,
          onToggle: onToggle,
          onNameChanged: onNameChanged,
          onPhoneChanged: onPhoneChanged,
          giftNameController: nameController,
          giftPhoneController: phoneController,
        ),
      ),
    );
  }

  testWidgets('shows only switch when isGift is false', (tester) async {
    await tester.pumpWidget(buildWidget(isGift: false));

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('shows input fields when isGift is true', (tester) async {
    await tester.pumpWidget(buildWidget(isGift: true));

    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('typing triggers callbacks', (tester) async {
    await tester.pumpWidget(buildWidget(isGift: true));

    // Find text fields and enter text
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    // Enter text in first field
    await tester.enterText(textFields.at(0), 'Rahma');
    verify(() => onNameChanged('Rahma')).called(1);

    // Enter text in second field
    await tester.enterText(textFields.at(1), '01000000000');
    verify(() => onPhoneChanged('01000000000')).called(1);
  });

  testWidgets('toggling switch triggers callback', (tester) async {
    await tester.pumpWidget(buildWidget(isGift: false));

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    verify(() => onToggle(true)).called(1);
  });
}
