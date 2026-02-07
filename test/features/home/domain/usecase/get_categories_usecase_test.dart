import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import 'get_categories_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late MockHomeRepo mockRepo;
  late GetCategoriesUseCase useCase;

  setUp(() {
    mockRepo = MockHomeRepo();
    useCase = GetCategoriesUseCase(mockRepo);
  });

  group('GetCategoriesUseCase', () {
    test(
      'should return list of CategoryModel when repo returns SuccessApiResult',
      () async {
        // ARRANGE
        final fakeHomeModel = HomeModel(
          message: "Welcome",
          products: [],
          categories: [
            CategoryModel(
              id: "1",
              name: "Flowers",
              slug: "flowers",
              image: "",
              createdAt: null,
              updatedAt: null,
              isSuperAdmin: false,
            ),
          ],
          bestSeller: [],
          occasions: [],
        );
        provideDummy<ApiResult<HomeModel>>(
          SuccessApiResult(data: fakeHomeModel),
        );
        when(mockRepo.getHomeData()).thenAnswer(
          (_) async => SuccessApiResult<HomeModel>(data: fakeHomeModel),
        );

        // ACT
        final result = await useCase.call();

        // ASSERT
        expect(result, isA<SuccessApiResult<List<CategoryModel>>>());
        final data = (result as SuccessApiResult).data;
        expect(data.length, 1);
        expect(data.first.name, "Flowers");
        verify(mockRepo.getHomeData()).called(1);
      },
    );

    test(
      'should return ErrorApiResult when repo returns ErrorApiResult',
      () async {
        // ARRANGE
        provideDummy<ApiResult<HomeModel>>(
          ErrorApiResult(error: 'Network error'),
        );
        when(
          mockRepo.getHomeData(),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Network error'));

        // ACT
        final result = await useCase.call();

        // ASSERT
        expect(result, isA<ErrorApiResult<List<CategoryModel>>>());
        expect((result as ErrorApiResult).error, 'Network error');
        verify(mockRepo.getHomeData()).called(1);
      },
    );
  });
}
