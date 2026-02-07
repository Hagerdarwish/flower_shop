import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/home/domain/usecase/get_occasions_usecase.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import 'get_occasions_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late MockHomeRepo mockRepo;
  late GetOccasionsUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    useCase = GetOccasionsUseCase(mockRepo);
  });

  group('GetOccasionsUseCase', () {
    test(
      'should return list of OccasionModel when repo returns SuccessApiResult',
      () async {
        final fakeHomeModel = HomeModel(
          message: "Welcome",
          products: [],
          categories: [],
          bestSeller: [],
          occasions: [
            OccasionModel(
              id: "1",
              name: "Valentine",
              slug: "valentine",
              image: "",
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              isSuperAdmin: false,
              productsCount: 0,
            ),
          ],
        );
        provideDummy<ApiResult<HomeModel>>(
          SuccessApiResult(data: fakeHomeModel),
        );
        when(mockRepo.getHomeData()).thenAnswer(
          (_) async => SuccessApiResult<HomeModel>(data: fakeHomeModel),
        );

        final result = await useCase.call();

        expect(result, isA<SuccessApiResult<List<OccasionModel>>>());
        final data = (result as SuccessApiResult).data;
        expect(data.length, 1);
        expect(data.first.name, "Valentine");
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

        expect(result, isA<ErrorApiResult<List<OccasionModel>>>());
        expect((result as ErrorApiResult).error, 'Network error');
        verify(mockRepo.getHomeData()).called(1);
      },
    );
  });
}
