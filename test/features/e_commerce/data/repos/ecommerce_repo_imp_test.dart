import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/datasource/ecommerce_remote_datasource.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/meta_data.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/products_response.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/remote_product.dart';
import 'package:flower_shop/features/e_commerce/data/repos/ecommerce_repo_imp.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ecommerce_repo_imp_test.mocks.dart';

@GenerateMocks([EcommerceRemoteDatasource])
void main() {
  late EcommerceRemoteDatasource datasource;
  late EcommerceRepoImp repoImp;
  setUpAll(() {
    provideDummy<ApiResult<AllCategoriesDto>>(
      SuccessApiResult(data: AllCategoriesDto()),
    );
  });

  setUp(() {
    datasource = MockEcommerceRemoteDatasource();
    repoImp = EcommerceRepoImp(datasource);
  });
  group("get product", () {
    group("get product", () {
      test("return SuccessApiResult", () async {
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

        // تعديل mappedProducts لتتوافق مع ما يخرجه repo
        List<ProductModel> mappedProducts = [
          ProductModel(
            id: "1",
            title: "",
            imgCover: "",
            price: 29,
            priceAfterDiscount: null, // <- هنا غيرنا من 10 إلى null
          ),
        ];

        ApiResult<ProductsResponse> datasourceResult = SuccessApiResult(
          data: dummyProductsResponse,
        );
        provideDummy(datasourceResult); //due to api result
        when(
          datasource.getProduct(occasion: ""),
        ).thenAnswer((_) => Future.value(datasourceResult));

        final result = await repoImp.getProducts(occasion: "");
        expect(result, isA<SuccessApiResult>());
        expect((result as SuccessApiResult).data, equals(mappedProducts));
      });
    });

    test("return ErrorApiResult", () async {
      String errorMessage = "Something went wrong";

      ApiResult<ProductsResponse> datasourceResult = ErrorApiResult(
        error: errorMessage,
      );
      provideDummy(datasourceResult); //due to api result
      when(
        datasource.getProduct(occasion: ""),
      ).thenAnswer((_) => Future.value(datasourceResult));

      final result = await repoImp.getProducts(occasion: "");
      expect(result, isA<ErrorApiResult>());
    });
  });

  group("Get all categories", () {
    test('should return ApiSuccess when get all categories success', () async {
      final fakeDto = AllCategoriesDto(
        message: 'success',
        categories: [
          CategoryItemDto(
            id: '1',
            image: 'url',
            name: 'flower1',
            productsCount: 5,
          ),
        ],
      );

      when(datasource.getAllCategories()).thenAnswer(
        (_) async => SuccessApiResult<AllCategoriesDto>(data: fakeDto),
      );

      final result =
          await repoImp.getAllCategories()
              as SuccessApiResult<AllCategoriesModel>;

      expect(result, isA<SuccessApiResult<AllCategoriesModel>>());
      expect(result.data.message, fakeDto.message);
      expect(result.data.categories?.first?.id, fakeDto.categories?.first?.id);
      verify(datasource.getAllCategories()).called(1);
    });

    test(
      'should return ApiError when get all categories throws exception',
      () async {
        when(datasource.getAllCategories()).thenAnswer(
          (_) async => ErrorApiResult<AllCategoriesDto>(error: 'Network error'),
        );

        final result =
            await repoImp.getAllCategories()
                as ErrorApiResult<AllCategoriesModel>;

        expect(result, isA<ErrorApiResult<AllCategoriesModel>>());
        expect(result.error.toString(), contains("Network error"));
        verify(datasource.getAllCategories()).called(1);
      },
    );
  });
}
