import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/datasource/home_remote_datasource/home_remote_datasource.dart';
import 'package:flower_shop/features/e_commerce/data/mappers/products_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repos/home_repo.dart';
import '../models/response/products_response.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeRemoteDatasource homeDatasource;

  HomeRepoImp(this.homeDatasource);

  @override
  Future<ApiResult<List<ProductModel>>> getProducts({String? occasion}) async {
    final result = await homeDatasource.getProduct(occasion: occasion);
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
