import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/home/data/datasource/home_remote_data_source.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/data/repos/home_repo_imp.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'home_repo_imp_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late HomeRepoImp homeRepo;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    homeRepo = HomeRepoImp(mockRemoteDataSource);
  });

  group('HomeRepoImp.getHomeData', () {
    test('returns SuccessApiResult<HomeModel> when remote datasource succeeds', () async {
      final fakeResponse = HomeResponse(
        message: "Welcome",
        products: [],
        categories: [],
        bestSeller: [],
        occasions: [],
      );

      when(mockRemoteDataSource.getHomeData())
          .thenAnswer((_) async => SuccessApiResult<HomeResponse>(data: fakeResponse));

      final result = await homeRepo.getHomeData();
      expect(result, isA<SuccessApiResult<HomeModel>>());
      final data = (result as SuccessApiResult).data;
      expect(data.message, "Welcome");
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test('returns ErrorApiResult<HomeModel> when remote datasource fails', () async {
      when(mockRemoteDataSource.getHomeData()).thenAnswer((_) async => ErrorApiResult<HomeResponse>(error: 'Network error'));
      final result = await homeRepo.getHomeData();
      expect(result, isA<ErrorApiResult<HomeModel>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test('returns ErrorApiResult<HomeModel> with unknown error for unexpected result', () async {
      when(mockRemoteDataSource.getHomeData()).thenAnswer((_) async => null);

      final result = await homeRepo.getHomeData();
      expect(result, isA<ErrorApiResult<HomeModel>>());
      expect((result as ErrorApiResult).error, 'Unknown error');
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });
  });
}
