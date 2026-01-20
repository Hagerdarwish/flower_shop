import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';

import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_occasions_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_products_usecase.dart';

import 'package:flower_shop/features/home/presentation/manager/home_cubit.dart';
import 'package:flower_shop/features/home/presentation/manager/home_intent.dart';
import 'package:flower_shop/features/home/presentation/manager/home_states.dart';
import 'package:flower_shop/features/home/presentation/manager/factory/home_factory.dart';

import 'home_cubit_test.mocks.dart';
import 'factory/home_factory_imp_test.mocks.dart'
    hide
        MockGetCategoriesUseCase,
        MockGetBestSellerUseCase,
        MockGetOccasionsUseCase,
        MockGetProductsUseCase;

@GenerateMocks([
  HomeFactory,
  GetCategoriesUseCase,
  GetBestSellerUseCase,
  GetOccasionsUseCase,
  GetProductsUseCase,
])
void main() {
  late MockHomeFactory mockFactory;
  late MockGetCategoriesUseCase mockCategories;
  late MockGetBestSellerUseCase mockBestSeller;
  late MockGetOccasionsUseCase mockOccasions;
  late MockGetProductsUseCase mockProducts;
  late HomeCubit cubit;

  setUp(() {
    mockFactory = MockHomeFactory();
    mockCategories = MockGetCategoriesUseCase();
    mockBestSeller = MockGetBestSellerUseCase();
    mockOccasions = MockGetOccasionsUseCase();
    mockProducts = MockGetProductsUseCase();

    // ربط الـ Factory بالـ UseCases
    when(mockFactory.categories()).thenReturn(mockCategories);
    when(mockFactory.bestSeller()).thenReturn(mockBestSeller);
    when(mockFactory.occasions()).thenReturn(mockOccasions);
    when(mockFactory.products()).thenReturn(mockProducts);

    cubit = HomeCubit(mockFactory);
  });

  // ====== البيانات التجريبية ======
  final categories = [CategoryModel(id: "1", name: "Roses", image: "img")];
  final bestSellers = [
    BestSellerModel(id: "1", title: "Red Rose", imgCover: "img", price: 100),
  ];
  final occasions = [OccasionModel(id: "1", name: "Birthday", image: "img")];
  final productsList = [
    ProductModel(id: "1", title: "Rose", imgCover: "img", price: 29),
  ];

  group("LoadHomeData Intent", () {
    blocTest<HomeCubit, HomeState>(
      'emits loading then success for all lists',
      build: () {
        // ====== provideDummy لكل UseCase ======
        provideDummy<ApiResult<List<CategoryModel>>>(
          SuccessApiResult(data: categories),
        );
        provideDummy<ApiResult<List<BestSellerModel>>>(
          SuccessApiResult(data: bestSellers),
        );
        provideDummy<ApiResult<List<OccasionModel>>>(
          SuccessApiResult(data: occasions),
        );
        provideDummy<ApiResult<List<ProductModel>>>(
          SuccessApiResult(data: productsList),
        );

        // ====== Stubs لكل UseCase ======
        when(
          mockCategories.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: categories));
        when(
          mockBestSeller.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: bestSellers));
        when(
          mockOccasions.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: occasions));
        when(
          mockProducts.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: productsList));

        return cubit;
      },
      act: (cubit) async {
        // استدعاء الدالة وانتظار اكتمالها
        cubit.doIntent(LoadHomeData());
      },
      wait: const Duration(milliseconds: 200),
      verify: (cubit) {
        final finalState = cubit.state;
        expect(finalState.categories.data, equals(categories));
        expect(finalState.bestSeller.data, equals(bestSellers));
        expect(finalState.occasions.data, equals(occasions));
        expect(finalState.products.data, equals(productsList));

        expect(finalState.categories.isSuccess, isTrue);
        expect(finalState.bestSeller.isSuccess, isTrue);
        expect(finalState.occasions.isSuccess, isTrue);
        expect(finalState.products.isSuccess, isTrue);
      },
    );
  });
}
