import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_states.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/pages/search_page.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([ProductsSearchCubit])
void main() {
  late MockProductsSearchCubit mockCubit;
  late StreamController<ProductsSearchStates> stateController;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  setUp(() {
    mockCubit = MockProductsSearchCubit();

    stateController = StreamController<ProductsSearchStates>.broadcast();

    when(mockCubit.stream).thenAnswer((_) => stateController.stream);
    when(
      mockCubit.state,
    ).thenReturn(ProductsSearchStates(products: Resource.initial()));

    if (GetIt.I.isRegistered<ProductsSearchCubit>()) {
      GetIt.I.unregister<ProductsSearchCubit>();
    }
    GetIt.I.registerSingleton<ProductsSearchCubit>(mockCubit);
  });

  tearDown(() {
    stateController.close();
    GetIt.I.reset();
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        home: BlocProvider<ProductsSearchCubit>(
          create: (_) => mockCubit,

          child: SearchPage(),
        ),
      ),
    );
  }

  testWidgets('initial state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(2));
    expect(find.text(LocaleKeys.initialSearchMsg.tr()), findsOneWidget);
    expect(find.byType(SearchTextField), findsOneWidget);
  });

  testWidgets('search loading state', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextField), 'rose');

    when(
      mockCubit.state,
    ).thenReturn(ProductsSearchStates(products: Resource.loading()));
    stateController.add(ProductsSearchStates(products: Resource.loading()));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(LocaleKeys.initialSearchMsg.tr()), findsNothing);
    expect(find.byType(SearchTextField), findsOneWidget);
  });

  testWidgets('search erroe state', (WidgetTester tester) async {
    when(
      mockCubit.state,
    ).thenReturn(ProductsSearchStates(products: Resource.error('Error msg')));

    stateController.add(
      ProductsSearchStates(products: Resource.error('Error msg')),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(SearchTextField), findsOneWidget);
  });

  testWidgets('success state with empty list', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(find.byType(TextField), 'roseeeeeee');

    when(
      mockCubit.state,
    ).thenReturn(ProductsSearchStates(products: Resource.success([])));
    stateController.add(ProductsSearchStates(products: Resource.success([])));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(Column), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == LocaleKeys.noProductsfound.tr() &&
            widget.style?.color == AppColors.grey,
      ),
      findsOneWidget,
    );
  });

  // testWidgets('success state with products', (WidgetTester tester) async {
  //   await mockNetworkImagesFor(() async {
  //     final mockProducts = [
  //       ProductModel(
  //         id: '1',
  //         title: 'Red Rose',
  //         price: 150,
  //         description: '',
  //         imgCover: '',
  //         quantity: 5,
  //         category: '',
  //         occasion: '',
  //         createdAt: DateTime.now(),
  //         images: [],
  //         isSuperAdmin: false,
  //         priceAfterDiscount: 130,
  //         rateAvg: 4,
  //         rateCount: 8,
  //         slug: '',
  //         sold: 30,
  //         updatedAt: DateTime.now(),
  //         v: 1,
  //       ),
  //       ProductModel(
  //         id: '2',
  //         title: 'White Rose',
  //         price: 150,
  //         description: '',
  //         imgCover: '',
  //         quantity: 1,
  //         category: '',
  //         occasion: '',
  //         createdAt: DateTime.now(),
  //         images: [],
  //         isSuperAdmin: false,
  //         priceAfterDiscount: 130,
  //         rateAvg: 4,
  //         rateCount: 8,
  //         slug: '',
  //         sold: 30,
  //         updatedAt: DateTime.now(),
  //         v: 1,
  //       ),
  //     ];

  //     await tester.pumpWidget(buildTestableWidget());
  //     await tester.pumpAndSettle();

  //     expect(find.byType(TextField), findsOneWidget);

  //     await tester.enterText(find.byType(TextField), 'Rose');

  //     when(mockCubit.state).thenReturn(
  //       ProductsSearchStates(products: Resource.success(mockProducts)),
  //     );

  //     stateController.add(
  //       ProductsSearchStates(products: Resource.success(mockProducts)),
  //     );

  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsNothing);
  //     expect(find.byType(GridView), findsOneWidget);
  //   });
  // });
}
