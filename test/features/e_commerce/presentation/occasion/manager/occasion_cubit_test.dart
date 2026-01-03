import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/usecase/get_product_usecase.dart';
import 'package:flower_shop/features/e_commerce/presentation/occasion/manager/occasion_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/occasion/manager/occasion_event.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasion_cubit_test.mocks.dart';

@GenerateMocks([GetProductUsecase])
void main() {
  late MockGetProductUsecase usecase;
  late OccasionCubit cubit;

  setUp(() {
    usecase = MockGetProductUsecase();
    cubit = OccasionCubit(usecase);
  });

  group("occasion cubit test", () {
    group("_getProduct", () {
      test(" emits loading", () {
        ApiResult<List<ProductModel>> result = ErrorApiResult(error: "null");
        provideDummy(result);
        when(
          usecase.call(occasion: ""),
        ).thenAnswer((_) => Future.value(result));

        cubit.doIntent(LoadInitialEvent(initialOccasion: ""));

        expect(cubit.state.products.isLoading, isTrue);
      });
      test(" emits success when usecase returns success", () async {
        List<ProductModel> products = [
          ProductModel(id: "id", title: "name", imgCover: "imageUrl", price: 20),
        ];
        ApiResult<List<ProductModel>> result = SuccessApiResult(data: products);
        provideDummy(result);
        when(
          usecase.call(occasion: ""),
        ).thenAnswer((_) => Future.value(result));

        cubit.doIntent(LoadInitialEvent(initialOccasion: ""));
        await Future.delayed(Duration.zero);
        verify(usecase.call(occasion: ""));
        expect(cubit.state.products, isA<Resource>());
        expect(cubit.state.products.status, equals(Status.success));
        expect(cubit.state.products.data, equals(products));
      });
      test(" emits error when usecase returns error", () async {
        String errorMessage = "Something went wrong";
        ApiResult<List<ProductModel>> result = ErrorApiResult(
          error: errorMessage,
        );
        provideDummy(result);
        when(
          usecase.call(occasion: ""),
        ).thenAnswer((_) => Future.value(result));

        cubit.doIntent(LoadInitialEvent(initialOccasion: ""));
        await Future.delayed(Duration.zero);
        verify(usecase.call(occasion: ""));
        expect(cubit.state.products, isA<Resource>());
        expect(cubit.state.products.status, equals(Status.error));
        expect(cubit.state.products.error, equals(errorMessage));
      });
      test(" emits error when usecase throws exception", () async {
        when(usecase.call(occasion: "")).thenThrow(Exception("test exception"));

        cubit.doIntent(LoadInitialEvent(initialOccasion: ""));
        await Future.delayed(Duration.zero);
        verify(usecase.call(occasion: ""));
        expect(cubit.state.products, isA<Resource>());
        expect(cubit.state.products.status, equals(Status.error));
        expect(
          cubit.state.products.error,
          equals(AppConstants.defaultErrorMessage),
        );
      });
    });

    group("_onTabChanged", () {
      const tTab = 'new_tab';
      final tProducts = [
        ProductModel(id: '1', title: 'Test Product', imgCover: 'image.png', price: 10),
      ];

      test('does not call usecase if tab is the same as the current one', () async {
        // arrange
        cubit.emit(cubit.state.copyWith(selectedItem: tTab));
        reset(usecase); // reset interactions after setting initial state.

        // act
        cubit.doIntent(TabChangedEvent(tTab));
        await Future.delayed(Duration.zero);

        // assert
        verifyNever(usecase.call(occasion: anyNamed('occasion')));
      });

      test('emits loading and then success state on tab change with successful data fetch', () async {
        // arrange
        final result = SuccessApiResult(data: tProducts);
        provideDummy(result);
        when(usecase.call(occasion: tTab)).thenAnswer((_) async => result);

        // act
        cubit.doIntent(TabChangedEvent(tTab));
        
        // assert for loading state
        expect(cubit.state.selectedItem, tTab);
        expect(cubit.state.products.status, Status.loading);

        await Future.delayed(Duration.zero);

        // assert for success state
        verify(usecase.call(occasion: tTab)).called(1);
        expect(cubit.state.products.status, Status.success);
        expect(cubit.state.products.data, tProducts);
      });

      test('emits loading and then error state on tab change with failed data fetch', () async {
        // arrange
        const errorMessage = 'Failed to fetch';
        ApiResult<List<ProductModel>> result = ErrorApiResult(error: errorMessage);
        provideDummy(result);
        when(usecase.call(occasion: tTab)).thenAnswer((_) async => result);

        // act
        cubit.doIntent(TabChangedEvent(tTab));

        // assert for loading state
        expect(cubit.state.selectedItem, tTab);
        expect(cubit.state.products.status, Status.loading);
        
        await Future.delayed(Duration.zero);

        // assert for error state
        verify(usecase.call(occasion: tTab)).called(1);
        expect(cubit.state.products.status, Status.error);
        expect(cubit.state.products.error, errorMessage);
      });
    });
  });
}
