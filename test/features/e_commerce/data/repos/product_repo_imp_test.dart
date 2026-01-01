import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/datasource/product_remote_datasource/product_remote_datasource.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/meta_data.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/products_response.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/remote_product.dart';
import 'package:flower_shop/features/e_commerce/data/repos/product_repo_imp.dart';
import 'package:flower_shop/features/e_commerce/domain/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repo_imp_test.mocks.dart';


@GenerateMocks([ProductRemoteDatasource])
void main() {
  late ProductRemoteDatasource datasource;
  late ProductRepoImp homeRepoImp;
  setUp(() {
    datasource = MockProductRemoteDatasource();
    homeRepoImp = ProductRepoImp(datasource);
  });
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
      List<ProductModel> mappedProducts = [
        ProductModel(
          id: "1",
          name: "",
          imageUrl: "",
          price: 29.99,
          discountPercent: 10,
          oldPrice: 35,
        ),

      ];
      ApiResult<ProductsResponse> datasourceResult = SuccessApiResult(
        data: dummyProductsResponse,
      );
      provideDummy(datasourceResult); //due to api result
      when(
        datasource.getProduct(occasion: "")
      ).thenAnswer((_) => Future.value(datasourceResult));

      final result = await homeRepoImp.getProducts(occasion: "");
      expect(result, isA<SuccessApiResult>());
      expect((result as SuccessApiResult).data, equals(mappedProducts));
    });
    test("return ErrorApiResult", () async {
      String errorMessage = "Something went wrong";

      ApiResult<ProductsResponse> datasourceResult = ErrorApiResult(
         error: errorMessage,
      );
      provideDummy(datasourceResult); //due to api result
      when(
          datasource.getProduct(occasion: "")
      ).thenAnswer((_) => Future.value(datasourceResult));

      final result = await homeRepoImp.getProducts(occasion: "");
      expect(result, isA<ErrorApiResult>());
    });

  });
}
