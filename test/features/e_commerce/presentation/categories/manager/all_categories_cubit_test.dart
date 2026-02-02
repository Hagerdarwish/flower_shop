import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/all_categories_usecase.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_states.dart';
import 'package:flower_shop/features/e_commerce/domain/models/sort_type.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/get_product_usecase.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../occasion/manager/occasion_cubit_test.mocks.dart';
import 'all_categories_cubit_test.mocks.dart' hide MockGetProductUsecase;

@GenerateMocks([AllCategoriesUsecase, GetProductUsecase])
void main() {
  late MockAllCategoriesUsecase mockAllCategoriesUsecase;
  late MockGetProductUsecase mockGetProductUsecase;
  late AllCategoriesCubit cubit;

  setUpAll(() {
    mockAllCategoriesUsecase = MockAllCategoriesUsecase();
    mockGetProductUsecase = MockGetProductUsecase();
    provideDummy<ApiResult<AllCategoriesModel>>(
      SuccessApiResult(data: AllCategoriesModel()),
    );
    provideDummy<ApiResult<List<ProductModel>>>(
      SuccessApiResult<List<ProductModel>>(data: []),
    );
  });
  setUp(() {
    cubit = AllCategoriesCubit(mockAllCategoriesUsecase, mockGetProductUsecase);
  });
  tearDown(() async {
    await cubit.close();
  });
  group('Get all categories event', () {
    blocTest(
      'emits loading, success when GetAllCategoriesEvent success',
      build: () {
        final fakeData = AllCategoriesModel(
          message: 'success',
          categories: [
            CategoryItemModel(
              id: '1',
              name: 'flower1',
              image: 'url',
              productsCount: 5,
            ),
          ],
        );

        when(mockGetProductUsecase.call()).thenAnswer(
          (_) async => SuccessApiResult<List<ProductModel>>(data: []),
        );

        when(mockAllCategoriesUsecase.call()).thenAnswer(
          (_) async => SuccessApiResult<AllCategoriesModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(GetAllCategoriesEvent());
      },

      expect: () => [
        isA<AllCategoriesStates>().having(
          (s) => s.allCategories?.status,
          'status',
          Status.loading,
        ),
        isA<AllCategoriesStates>().having(
          (s) => s.allCategories?.status,
          'status',
          Status.success,
        ),
        isA<AllCategoriesStates>().having(
          (s) => s.products?.status,
          'products status',
          Status.loading,
        ),
        isA<AllCategoriesStates>().having(
          (s) => s.products?.status,
          'products status',
          Status.success,
        ),
      ],
      verify: (_) {
        expect(cubit.categoriesList.first.name, 'All');
        expect(cubit.categoriesList.length, 2);
        expect(cubit.state.allCategories?.data?.categories?.first?.id, '1');
        verify(mockAllCategoriesUsecase.call()).called(1);
      },
    );

    blocTest(
      'emits loading, error when GetAllCategoriesEvent fails',
      build: () {
        when(mockAllCategoriesUsecase.call()).thenAnswer(
          (_) async => ErrorApiResult<AllCategoriesModel>(error: 'error'),
        );

        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetAllCategoriesEvent()),
      expect: () => [
        isA<AllCategoriesStates>().having(
          (s) => s.allCategories?.status,
          'status',
          Status.loading,
        ),
        isA<AllCategoriesStates>().having(
          (s) => s.allCategories?.status,
          'status',
          Status.error,
        ),
      ],
      verify: (_) {
        expect(cubit.state.allCategories?.error, 'error');
        verify(mockAllCategoriesUsecase.call()).called(1);
      },
    );
  });

  group('Select category', () {
    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'calls getProducts when selecting All category',
      build: () {
        when(
          mockGetProductUsecase.call(category: anyNamed('category')),
        ).thenAnswer(
          (_) async => SuccessApiResult<List<ProductModel>>(data: []),
        );
        return cubit;
      },
      seed: () {
        cubit.selectedIndex = 1;
        cubit.categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          CategoryItemModel(id: '1', name: 'Flowers'),
        ];
        return AllCategoriesStates(
          allCategories: Resource.success(AllCategoriesModel()),
        );
      },
      act: (cubit) {
        clearInteractions(mockGetProductUsecase);
        cubit.doIntent(SelectCategoryEvent(selectedIndex: 0));
      },
      verify: (_) {
        verify(
          mockGetProductUsecase.call(category: anyNamed('category')),
        ).called(1);
      },
    );

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'does nothing when selecting same category index',
      build: () => cubit,
      seed: () {
        cubit.selectedIndex = 1;
        cubit.categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          CategoryItemModel(id: '1', name: 'Flowers'),
        ];
        return AllCategoriesStates(
          allCategories: Resource.success(AllCategoriesModel()),
        );
      },
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(selectedIndex: 1)),
      expect: () => [],
      verify: (_) {
        verifyNever(mockGetProductUsecase.call(category: anyNamed('category')));
      },
    );
  });

  group('Get products method', () {
    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'emits products loading then success when selecting category',
      build: () {
        when(mockGetProductUsecase.call(category: '1')).thenAnswer(
          (_) async => SuccessApiResult<List<ProductModel>>(data: []),
        );
        return cubit;
      },
      seed: () {
        cubit.categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          CategoryItemModel(id: '1', name: 'Flowers'),
        ];
        return AllCategoriesStates(
          allCategories: Resource.success(AllCategoriesModel()),
        );
      },
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(selectedIndex: 1)),
      expect: () => [
        isA<AllCategoriesStates>(),
        isA<AllCategoriesStates>(),
        isA<AllCategoriesStates>().having(
          (s) => s.products?.status,
          'products status',
          Status.success,
        ),
      ],
      verify: (_) {
        verify(mockGetProductUsecase.call(category: '1')).called(1);
      },
    );
    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'emits products error when getProducts fails',
      build: () {
        when(
          mockGetProductUsecase.call(category: anyNamed('category')),
        ).thenAnswer(
          (_) async => ErrorApiResult<List<ProductModel>>(error: 'error'),
        );

        return cubit;
      },
      seed: () {
        cubit.categoriesList = [
          CategoryItemModel(id: '0', name: 'All'),
          CategoryItemModel(id: '1', name: 'Flowers'),
        ];
        return AllCategoriesStates(
          allCategories: Resource.success(AllCategoriesModel()),
        );
      },
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(selectedIndex: 1)),
      expect: () => [
        isA<AllCategoriesStates>(),
        isA<AllCategoriesStates>(),
        isA<AllCategoriesStates>().having(
          (s) => s.products?.status,
          'products status',
          Status.error,
        ),
      ],
      verify: (_) {
        expect(cubit.state.products?.error, 'error');
      },
    );
  });

  group('Apply sort', () {
    late List<ProductModel> products;

    setUp(() {
      products = [
        ProductModel(
          id: '1',
          title: 'Product 1',
          price: 100,
          priceAfterDiscount: 80,
          createdAt: DateTime(2023, 1, 1),
        ),
        ProductModel(
          id: '2',
          title: 'Product 2',
          price: 200,
          priceAfterDiscount: 150,
          createdAt: DateTime(2023, 2, 1),
        ),
        ProductModel(
          id: '3',
          title: 'Product 3',
          price: 50,
          priceAfterDiscount: 50,
          createdAt: DateTime(2023, 3, 1),
        ),
      ];

      cubit.emit(
        AllCategoriesStates(
          allCategories: Resource.success(AllCategoriesModel()),
          products: Resource.success(List<ProductModel>.from(products)),
        ),
      );
    });

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'sorts by lowest price',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ApplySortEvent(SortType.lowestPrice)),
      verify: (_) {
        final sorted = cubit.state.products?.data;
        expect(sorted![0].price, 50);
        expect(sorted[1].price, 100);
        expect(sorted[2].price, 200);
      },
    );

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'sorts by highest price',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ApplySortEvent(SortType.highestPrice)),
      verify: (_) {
        final sorted = cubit.state.products?.data;
        expect(sorted![0].price, 200);
        expect(sorted[1].price, 100);
        expect(sorted[2].price, 50);
      },
    );

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'sorts by newest',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ApplySortEvent(SortType.newest)),
      verify: (_) {
        final sorted = cubit.state.products?.data;
        expect(sorted![0].id, '3'); // أحدث
        expect(sorted[1].id, '2');
        expect(sorted[2].id, '1'); // أقدم
      },
    );

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'sorts by oldest',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ApplySortEvent(SortType.oldest)),
      verify: (_) {
        final sorted = cubit.state.products?.data;
        expect(sorted![0].id, '1'); // أقدم
        expect(sorted[1].id, '2');
        expect(sorted[2].id, '3'); // أحدث
      },
    );

    blocTest<AllCategoriesCubit, AllCategoriesStates>(
      'sorts by discount',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ApplySortEvent(SortType.discount)),
      verify: (_) {
        final sorted = cubit.state.products?.data;
        final discount = (ProductModel p) =>
            (p.price ?? 0) - (p.priceAfterDiscount ?? p.price ?? 0);
        expect(discount(sorted![0]), 50); // أكبر خصم
        expect(discount(sorted[1]), 20);
        expect(discount(sorted[2]), 0); // بدون خصم
      },
    );
  });
}
