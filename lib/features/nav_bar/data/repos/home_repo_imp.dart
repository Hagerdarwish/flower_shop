import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/nav_bar/data/mappers/products_mapper.dart';
import 'package:flower_shop/features/nav_bar/data/models/response/products_response.dart';
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repos/home_repo.dart';
import '../datasource/home_remote_datasouce/home_remote_datasource.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeRemoteDatasource homeDatasource;

  HomeRepoImp(this.homeDatasource);

  @override
  Future<ApiResult<List<ProductModel>>> getProducts({
    String? occasion,
    String? category,
  }) async {
    final result = await homeDatasource.getProduct(
      occasion: occasion,
      category: category,
    );
    switch (result) {
      case SuccessApiResult<ProductsResponse>():
        return SuccessApiResult(
          data: result.data.products!.map((remoteProduct) {
            return remoteProduct.toProduct();
          }).toList(),
        );
      case ErrorApiResult<ProductsResponse>():
        return ErrorApiResult(error: result.error);
    }
  }
}
