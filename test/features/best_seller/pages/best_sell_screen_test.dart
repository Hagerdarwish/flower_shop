 import 'package:flower_shop/features/best_seller/best_seller_card/best_seller_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/best_seller/pages/best_sell_screen.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:easy_localization/easy_localization.dart';

// Dummy UseCase للتست
class TestGetBestSellerUseCase implements GetBestSellerUseCase {
  final ApiResult<List<BestSellerModel>> result;

  TestGetBestSellerUseCase(this.result);

  @override
  Future<ApiResult<List<BestSellerModel>>> call() async => result;
}

void main() async {
  // لتشغيل EasyLocalization في الاختبارات
  TestWidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations', // المسار اللي عندك للملفات ARB أو JSON
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: BlocProvider(
              create: (context) => BestSellerCubit(useCase),
              child: const BestSellerScreen(),
            ),
          ),
        ),
      );

      // انتظر الـ Widget ينتهي من البناء
      await tester.pumpAndSettle();

      // استخدام النص المناسب مع localization
      expect(find.text('best_seller'.tr()), findsOneWidget);
    });

    testWidgets('should show loading initially', (WidgetTester tester) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: productsList),
      );

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: BlocProvider(
              create: (context) => BestSellerCubit(useCase),
              child: const BestSellerScreen(),
            ),
          ),
        ),
      );

      // الحالة الأولية: CircularProgressIndicator
      await tester.pump(); // مرحلة البناء الأولى
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show products when loaded', (WidgetTester tester) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: productsList),
      );

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: BlocProvider(
              create: (context) => BestSellerCubit(useCase),
              child: const BestSellerScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(BestSellerCard), findsNWidgets(productsList.length));
    });

    testWidgets('should show empty state for empty list', (WidgetTester tester) async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: []),
      );

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: BlocProvider(
              create: (context) => BestSellerCubit(useCase),
              child: const BestSellerScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Text), findsWidgets); // أي نصوص تظهر في empty state
    });

    testWidgets('should show error state when loading fails', (WidgetTester tester) async {
      final useCase = TestGetBestSellerUseCase(
        ErrorApiResult<List<BestSellerModel>>(error: 'Test error'),
      );

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: BlocProvider(
              create: (context) => BestSellerCubit(useCase),
              child: const BestSellerScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsWidgets); // نص الخطأ ظاهر
      expect(find.byType(GridView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
 