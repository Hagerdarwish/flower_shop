import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/best_seller/best_seller_card/best_seller_card.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';

// Create a simple wrapper that provides default localization
class TestBestSellerCard extends StatelessWidget {
  final BestSellerModel product;
  final VoidCallback? onTap;
  final VoidCallback onAddToCart;
  final EdgeInsetsGeometry padding;

  const TestBestSellerCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onTap,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 250,
            height: 400,
            child: BestSellerCard(
              product: product,
              onTap: onTap,
              onAddToCart: onAddToCart,
              padding: padding,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  final sampleProduct = BestSellerModel(
    id: '1',
    title: 'Test Product',
    price: 1000,
    imgCover: 'https://example.com/test.jpg',
  );

  group('BestSellerCard Basic Tests', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestBestSellerCard(
          product: sampleProduct,
          onTap: () {},
          onAddToCart: () {},
        ),
      );

      expect(find.byType(BestSellerCard), findsOneWidget);
    });

    testWidgets('displays product title', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestBestSellerCard(
          product: sampleProduct,
          onTap: () {},
          onAddToCart: () {},
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('displays price', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestBestSellerCard(
          product: sampleProduct,
          onTap: () {},
          onAddToCart: () {},
        ),
      );

      expect(find.textContaining('EGP'), findsOneWidget);
    });

    testWidgets('has tappable area', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        TestBestSellerCard(
          product: sampleProduct,
          onTap: () => tapped = true,
          onAddToCart: () {},
        ),
      );

      await tester.tap(find.byType(InkWell).first);
      await tester.pump();
      
      expect(tapped, isTrue);
    });
  });
}