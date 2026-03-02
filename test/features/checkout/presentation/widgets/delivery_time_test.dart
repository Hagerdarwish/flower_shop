import 'package:flower_shop/features/checkout/presentation/widgets/delivery_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DeliveryTimeWidget renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DeliveryTimeWidget())),
    );

    expect(find.byType(DeliveryTimeWidget), findsOneWidget);

    expect(find.byType(Text), findsWidgets);
  });
}
