import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/get_product_usecase.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_states.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../occasion/manager/occasion_cubit_test.mocks.dart';

@GenerateMocks([GetProductUsecase])
void main() {
  late MockGetProductUsecase mockGetProductUsecase;
  late ProductsSearchCubit cubit;

  setUpAll(() {
    mockGetProductUsecase = MockGetProductUsecase();
    provideDummy<ApiResult<List<ProductModel>>>(
      SuccessApiResult<List<ProductModel>>(data: []),
    );
  });
  setUp(() {
    cubit = ProductsSearchCubit(mockGetProductUsecase);
  });
  tearDown(() async {
    await cubit.close();
  });
  group('Search', () {
    blocTest(
      'emits loading, success when search success',
      build: () {
        final fakeData = [
          ProductModel(
            id: '1',
            title: 'Rose',
            price: 20,
            description: 'Red Rose',
          ),
        ];

        when(mockGetProductUsecase.call(search: "rose")).thenAnswer(
          (_) async => SuccessApiResult<List<ProductModel>>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        return cubit.doIntent(GetProductsByIdIntent(search: "rose"));
      },

      expect: () => [
        isA<ProductsSearchStates>().having(
          (s) => s.products?.status,
          'status',
          Status.loading,
        ),
        isA<ProductsSearchStates>().having(
          (s) => s.products?.status,
          'status',
          Status.success,
        ),
      ],
      verify: (_) {
        expect(cubit.state.products?.data?.first.title, 'Rose');
        expect(cubit.state.products?.data?.first.price, 20);
        expect(cubit.state.products?.data?.length, 1);
        verify(mockGetProductUsecase.call(search: 'rose')).called(1);
      },
    );

    blocTest<ProductsSearchCubit, ProductsSearchStates>(
      'emits [loading, error] when search fails',
      build: () {
        when(mockGetProductUsecase.call(search: 'rose')).thenAnswer(
          (_) async =>
              ErrorApiResult<List<ProductModel>>(error: 'Error occurred'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetProductsByIdIntent(search: 'rose')),
      expect: () => [
        isA<ProductsSearchStates>().having(
          (s) => s.products?.status,
          'status',
          Status.loading,
        ),
        isA<ProductsSearchStates>().having(
          (s) => s.products?.status,
          'status',
          Status.error,
        ),
      ],
    );
  });
}
