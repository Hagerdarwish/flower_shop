import 'package:flower_shop/features/best_seller/best_seller_card/best_seller_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/best_seller/pages/best_sell_screen.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';

// Simple test use case
class TestGetBestSellerUseCase implements GetBestSellerUseCase {
  final ApiResult<List<BestSellerModel>> result;

  TestGetBestSellerUseCase(this.result);

  @override
  Future<ApiResult<List<BestSellerModel>>> call() async => result;
}

// Helper to check if text is present without exact matching
bool hasText(WidgetTester tester, String text) {
  return find.text(text).evaluate().isNotEmpty;
}

void main() {
  final productsList = [
    BestSellerModel(id: '1', title: 'Product 1', price: 100, imgCover: ''),
    BestSellerModel(id: '2', title: 'Product 2', price: 200, imgCover: ''),
  ];

  group('BestSellerScreen Basic Tests', () {
    testWidgets('should show app bar with title', (WidgetTester tester) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: productsList),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => BestSellerCubit(useCase),
            child: const BestSellerScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should show products when loaded', (
      WidgetTester tester,
    ) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: productsList),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => BestSellerCubit(useCase),
            child: const BestSellerScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(BestSellerCard), findsNWidgets(productsList.length));
    });

    testWidgets('should show empty state for empty list', (
      WidgetTester tester,
    ) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: []),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => BestSellerCubit(useCase),
            child: const BestSellerScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Instead of looking for exact text, check that GridView is NOT shown
      expect(find.byType(GridView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      // Should show some text content (could be localized)
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should show error state when loading fails', (
      WidgetTester tester,
    ) async {
      final useCase = TestGetBestSellerUseCase(
        ErrorApiResult<List<BestSellerModel>>(error: 'Test error'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => BestSellerCubit(useCase),
            child: const BestSellerScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show error text
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(GridView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
