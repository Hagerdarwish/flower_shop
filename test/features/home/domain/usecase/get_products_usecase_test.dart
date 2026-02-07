import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/home/domain/usecase/get_products_usecase.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import 'get_products_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late MockHomeRepo mockRepo;
  late GetProductsUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    useCase = GetProductsUseCase(mockRepo);
  });

  group('GetProductsUseCase', () {
    test(
      'should return list of ProductModel when repo returns SuccessApiResult',
      () async {
        final fakeHomeModel = HomeModel(
          message: "Welcome",
          products: [
            ProductModel(
              id: "1",
              title: "Red Roses",
              slug: "red-roses",
              description: "",
              imgCover: "",
              images: [],
              price: 50,
              priceAfterDiscount: null,
              quantity: 10,
              category: "",
              occasion: "",
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0,
              isSuperAdmin: false,
              sold: 0,
              rateAvg: 0,
              rateCount: 0,
            ),
          ],
          categories: [],
          bestSeller: [],
          occasions: [],
        );
        provideDummy<ApiResult<HomeModel>>(
          SuccessApiResult(data: fakeHomeModel),
        );
        when(mockRepo.getHomeData()).thenAnswer(
          (_) async => SuccessApiResult<HomeModel>(data: fakeHomeModel),
        );

        final result = await useCase.call();

        expect(result, isA<SuccessApiResult<List<ProductModel>>>());
        final data = (result as SuccessApiResult).data;
        expect(data.length, 1);
        expect(data.first.title, "Red Roses");
        verify(mockRepo.getHomeData()).called(1);
      },
    );

    test(
      'should return ErrorApiResult when repo returns ErrorApiResult',
      () async {
        provideDummy<ApiResult<HomeModel>>(
          ErrorApiResult(error: 'Network error'),
        );
        when(
          mockRepo.getHomeData(),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Network error'));

        final result = await useCase.call();

        expect(result, isA<ErrorApiResult<List<ProductModel>>>());
        expect((result as ErrorApiResult).error, 'Network error');
        verify(mockRepo.getHomeData()).called(1);
      },
    );
  });
}
