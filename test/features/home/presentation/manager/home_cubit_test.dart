import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/presentation/manager/home_cubit.dart';
import 'package:flower_shop/features/home/presentation/manager/home_intent.dart';
import 'package:flower_shop/features/home/presentation/manager/home_states.dart';
import 'package:flower_shop/features/home/presentation/manager/factory/home_factory.dart';

import 'factory/home_factory_imp_test.mocks.dart';
import 'home_cubit_test.mocks.dart';

@GenerateMocks([HomeFactory])
void main() {
late MockHomeFactory mockFactory;
late MockGetCategoriesUseCase mockCategories;
late MockGetBestSellerUseCase mockBestSeller;
late MockGetOccasionsUseCase mockOccasions;
late HomeCubit cubit;

setUp(() {
  mockFactory = MockHomeFactory();
  mockCategories = MockGetCategoriesUseCase();
  mockBestSeller = MockGetBestSellerUseCase();
  mockOccasions = MockGetOccasionsUseCase();

  when(mockFactory.categories()).thenReturn(mockCategories);
  when(mockFactory.bestSeller()).thenReturn(mockBestSeller);
  when(mockFactory.occasions()).thenReturn(mockOccasions);

  cubit = HomeCubit(mockFactory);
});

  final categories = [
    CategoryModel(id: "1", name: "Roses", image: "img"),
  ];

  final bestSellers = [
    BestSellerModel(id: "1", title: "Red Rose", imgCover: "img", price: 100),
  ];

  final occasions = [
    OccasionModel(id: "1", name: "Birthday", image: "img"),
  ];

  group("LoadHomeData Intent", () {
    blocTest<HomeCubit, HomeState>(
  'emits loading then success states',
  build: () {
        provideDummy<ApiResult<List<CategoryModel>>>(
      SuccessApiResult(data: categories),
    );
    provideDummy<ApiResult<List<BestSellerModel>>>(
      SuccessApiResult(data: bestSellers),
    );
    provideDummy<ApiResult<List<OccasionModel>>>(
      SuccessApiResult(data: occasions),
    );
    when(mockCategories.call())
        .thenAnswer((_) async => SuccessApiResult(data: categories));

    when(mockBestSeller.call())
        .thenAnswer((_) async => SuccessApiResult(data: bestSellers));

    when(mockOccasions.call())
        .thenAnswer((_) async => SuccessApiResult(data: occasions));

    return cubit;
  },
  act: (cubit) => cubit.doIntent(LoadHomeData()),
  expect: () => [
    isA<HomeState>()
        .having((s) => s.categories.status, 'categories', Status.loading)
        .having((s) => s.bestSeller.status, 'bestSeller', Status.loading)
        .having((s) => s.occasions.status, 'occasions', Status.loading),
    isA<HomeState>().having((s) => s.categories.data, 'categories', categories),
    isA<HomeState>().having((s) => s.bestSeller.data, 'bestSeller', bestSellers),
    isA<HomeState>().having((s) => s.occasions.data, 'occasions', occasions),
  ],
);
  }
  );
}
