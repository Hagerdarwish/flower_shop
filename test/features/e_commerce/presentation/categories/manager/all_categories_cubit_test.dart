import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/all_categories_usecase.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_states.dart';
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
}
