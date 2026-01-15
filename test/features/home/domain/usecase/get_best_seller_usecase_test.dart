import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import 'get_best_seller_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late MockHomeRepo mockRepo;
  late GetBestSellerUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    useCase = GetBestSellerUseCase(mockRepo);
  });

  group('GetBestSellerUseCase', () {
    test(
      'should return list of BestSellerModel when repo returns SuccessApiResult',
      () async {
        final fakeHomeModel = HomeModel(
          message: "Welcome",
          products: [],
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
        expect(result, isA<SuccessApiResult<List<BestSellerModel>>>());
        verify(mockRepo.getHomeData()).called(1);
      },
    );

    test(
      'should return ErrorApiResult when repo returns ErrorApiResult',
      () async {
        provideDummy<ApiResult<HomeModel>>(SuccessApiResult(data: HomeModel()));
        when(
          mockRepo.getHomeData(),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Network error'));

        final result = await useCase.call();

        expect(result, isA<ErrorApiResult<List<BestSellerModel>>>());
        expect((result as ErrorApiResult).error, 'Network error');
        verify(mockRepo.getHomeData()).called(1);
      },
    );
  });
}
