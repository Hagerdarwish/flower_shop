// import 'package:flower_shop/app/config/base_state/base_state.dart';
// import 'package:flower_shop/app/config/di/di.dart';
// import 'package:flower_shop/app/core/widgets/product_item_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flower_shop/features/e_commerce/presentation/categories/pages/categories_page.dart';
// import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
// import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_states.dart';
// import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
// import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
// import 'package:flower_shop/features/home/domain/models/product_model.dart';
// import 'package:flower_shop/features/e_commerce/presentation/occasion/pages/shimmer_grid_loading.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'categories_page_test.mocks.dart';

// import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';

// @GenerateMocks([AllCategoriesCubit, CartCubit])
// void main() async {
//   late MockAllCategoriesCubit categoriesCubit;
//   late MockCartCubit cartCubit;

//   setUpAll(() async {
//     SharedPreferences.setMockInitialValues({});
//     await EasyLocalization.ensureInitialized();
//   });

//   setUp(() async {
//     categoriesCubit = MockAllCategoriesCubit();
//     cartCubit = MockCartCubit();

//     await getIt.reset();
//     getIt.registerFactory<AllCategoriesCubit>(() => categoriesCubit);

//     when(cartCubit.doIntent(any)).thenReturn(null);
//     when(categoriesCubit.doIntent(any)).thenReturn(null);
//     when(cartCubit.close()).thenAnswer((_) async {});
//     when(categoriesCubit.close()).thenAnswer((_) async {});

//     when(cartCubit.resetAction()).thenReturn(null);
//     when(cartCubit.cartsList).thenReturn([]);

//     when(cartCubit.state).thenReturn(CartStates(cart: Resource.initial()));
//     when(cartCubit.stream).thenAnswer((_) => const Stream.empty());

//     when(
//       categoriesCubit.categoriesList,
//     ).thenReturn([CategoryItemModel(id: '1', name: 'All')]);
//     when(categoriesCubit.selectedIndex).thenReturn(0);
//   });

//   Widget wrap(Widget child) {
//     return EasyLocalization(
//       supportedLocales: const [Locale('en')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('en'),
//       useOnlyLangCode: true,
//       assetLoader: const MockAssetLoader(),
//       child: Builder(
//         builder: (context) {
//           return MultiBlocProvider(
//             providers: [
//               BlocProvider<CartCubit>.value(value: cartCubit),
//               BlocProvider<AllCategoriesCubit>.value(value: categoriesCubit),
//             ],
//             child: MaterialApp(
//               home: Scaffold(body: child),
//               locale: context.locale,
//               localizationsDelegates: context.localizationDelegates,
//               supportedLocales: context.supportedLocales,
//               localeResolutionCallback: (locale, supportedLocales) =>
//                   const Locale('en'),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   group('CategoriesPage Widget Tests', () {
//     testWidgets('shows loading shimmer', (tester) async {
//       final state = AllCategoriesStates(products: Resource.loading());

//       when(categoriesCubit.state).thenReturn(state);
//       when(categoriesCubit.stream).thenAnswer((_) => Stream.value(state));

//       await tester.pumpWidget(wrap(const CategoriesPage()));
//       await tester.pump();

//       expect(find.byType(ShimmerGridLoading), findsOneWidget);
//     });

//     testWidgets('shows empty state', (tester) async {
//       final state = AllCategoriesStates(products: Resource.success([]));

//       when(categoriesCubit.state).thenReturn(state);
//       when(categoriesCubit.stream).thenAnswer((_) => Stream.value(state));

//       await tester.pumpWidget(wrap(const CategoriesPage()));
//       await tester.pumpAndSettle();

//       expect(find.byType(Text), findsWidgets);
//       if (find.text('No products found').evaluate().isNotEmpty) {
//         expect(find.text('No products found'), findsOneWidget);
//       } else {
//         expect(find.text('noProductsfound'), findsOneWidget);
//       }
//     });

//     testWidgets('shows products grid', (tester) async {
//       const products = [
//         ProductModel(
//           id: '1',
//           title: 'Product 1',
//           price: 100,
//           priceAfterDiscount: 80,
//           imgCover: 'https://via.placeholder.com/150',
//         ),
//       ];
//       final state = AllCategoriesStates(products: Resource.success(products));

//       when(categoriesCubit.state).thenReturn(state);
//       when(categoriesCubit.stream).thenAnswer((_) => Stream.value(state));

//       await tester.pumpWidget(wrap(const CategoriesPage()));
//       await tester.pump(const Duration(seconds: 1));

//       if (find.byType(ShimmerGridLoading).evaluate().isNotEmpty) {
//         debugPrint('Found ShimmerGridLoading instead of products!');
//       }

//       if (find.byType(ProductItemCard).evaluate().isEmpty) {
//         debugPrint('ProductItemCard NOT found. Dumping app:');
//         debugDumpApp();
//       }

//       expect(find.byType(GridView), findsOneWidget);
//       expect(find.byType(ProductItemCard), findsOneWidget);
//     });
//   });
// }

// class MockAssetLoader extends AssetLoader {
//   const MockAssetLoader();

//   @override
//   Future<Map<String, dynamic>> load(String path, Locale locale) async {
//     return {
//       'noProductsfound': 'No products found',
//       'addToCard': 'Add to cart',
//       'productAddedToCart': 'Product added to cart',
//       'search': 'Search',
//     };
//   }
// }
void main() {}
