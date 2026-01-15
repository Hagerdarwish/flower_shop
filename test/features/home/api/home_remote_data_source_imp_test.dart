import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/api/home_remote_data_source_imp.dart';
import 'package:flower_shop/features/home/data/models/product_model.dart';
import 'package:flower_shop/features/home/data/models/category_model.dart';
import 'package:flower_shop/features/home/data/models/best_seller_model.dart';
import 'package:flower_shop/features/home/data/models/occasion_model.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import '../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late HomeRemoteDataSourceImp dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = HomeRemoteDataSourceImp(mockApiClient);
  });

  group("HomeRemoteDataSourceImp.getHomeData()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        final fakeResponse = HomeResponse(
          message: "Welcome",
          products: [Product(id: "1", title: "Rose", price: 10)],
          categories: [Category(Id: "1", name: "Flowers")],
          bestSeller: [BestSeller(id: "1", title: "Rose Bouquet")],
          occasions: [Occasion(Id: "1", name: "Birthday")],
        );

        final dioResponse = Response<HomeResponse>(
          requestOptions: RequestOptions(path: '/home'),
          data: fakeResponse,
          statusCode: 200,
        );
        final fakeHttpResponse = HttpResponse<HomeResponse>(
          dioResponse.data!,
          dioResponse,
        );
        when(
          mockApiClient.getHomeData(),
        ).thenAnswer((_) async => fakeHttpResponse);

        final result = await dataSource.getHomeData();

        expect(result, isA<SuccessApiResult<HomeResponse>>());
        final data = (result as SuccessApiResult).data;
        expect(data.message, "Welcome");
        expect(data.products?.length, 1);
        expect(data.categories?.first.name, "Flowers");
        verify(mockApiClient.getHomeData()).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      when(mockApiClient.getHomeData()).thenThrow(Exception("network error"));
      final result = await dataSource.getHomeData();

      expect(result, isA<ErrorApiResult<HomeResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );
      verify(mockApiClient.getHomeData()).called(1);
    });
  });
}
