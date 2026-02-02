import 'package:dio/dio.dart';
import 'package:flower_shop/features/e_commerce/data/datasource/ecommerce_remote_datasource_impl.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/meta_data.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/products_response.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/remote_product.dart';

import '../../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient apiClient;
  late EcommerceRemoteDatasourceImpl datasource;

  setUp(() {
    apiClient = MockApiClient();
    datasource = EcommerceRemoteDatasourceImpl(apiClient);
  });

  group('EcommerceRemoteDatasourceImpl.getProduct', () {
    test('returns SuccessApiResult when apiClient succeeds', () async {
      final dummyProductsResponse = ProductsResponse(
        message: "Success",
        metadata: Metadata(currentPage: 1, totalPages: 5, limit: 10),
        products: [
          RemoteProduct(
            id: "1",
            description: "A beautiful bouquet of red roses.",
            price: 29.99,
            category: "bouquets",
          ),
        ],
      );

      final httpResponse = HttpResponse(
        dummyProductsResponse,
        Response(
          requestOptions: RequestOptions(path: '/products'),
          statusCode: 200,
        ),
      );

      when(
        apiClient.getProducts(occasion: anyNamed('occasion')),
      ).thenAnswer((_) async => httpResponse);

      final result = await datasource.getProduct(occasion: "");

      expect(result, isA<SuccessApiResult<ProductsResponse>>());
      expect(
        (result as SuccessApiResult<ProductsResponse>).data.message,
        "Success",
      );
    });

    test('returns ErrorApiResult when apiClient throws DioException', () async {
      when(apiClient.getProducts(occasion: anyNamed('occasion'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/products'),
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await datasource.getProduct(occasion: "");

      expect(result, isA<ErrorApiResult<ProductsResponse>>());
    });
  });

  group('EcommerceRemoteDataSourceImpl.allCaegories', () {
    test('return ApiSuccess when get all categories', () async {
      final fakeDto = AllCategoriesDto(
        message: 'success',
        categories: [
          CategoryItemDto(
            id: '1',
            name: 'flower1',
            productsCount: 5,
            image: 'url',
          ),
        ],
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/categories'),
          statusCode: 200,
        ),
      );

      when(apiClient.getAllCategories()).thenAnswer((_) async => fakeResponse);

      final result =
          await datasource.getAllCategories()
              as SuccessApiResult<AllCategoriesDto>;

      expect(result, isA<SuccessApiResult<AllCategoriesDto>>());
      expect(result.data.message, fakeDto.message);
      expect(result.data.categories?.length, fakeDto.categories?.length);
      verify(apiClient.getAllCategories()).called(1);
    });

    test('return ApiError when get all categories throw exception', () async {
      when(apiClient.getAllCategories()).thenThrow(Exception('Network error'));

      final result =
          await datasource.getAllCategories()
              as ErrorApiResult<AllCategoriesDto>;

      expect(result, isA<ErrorApiResult<AllCategoriesDto>>());
      expect(result.error, contains("Network error"));
      verify(apiClient.getAllCategories()).called(1);
    });
  });
}
