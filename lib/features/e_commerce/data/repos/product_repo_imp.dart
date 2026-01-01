import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/mappers/products_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repos/product_repo.dart';
import '../datasource/product_remote_datasource/product_remote_datasource.dart';
import '../models/response/products_response.dart';

@Injectable(as: ProductRepo)
class ProductRepoImp implements ProductRepo {
  final ProductRemoteDatasource homeDatasource;

  ProductRepoImp(this.homeDatasource);

  @override
  Future<ApiResult<List<ProductModel>>> getProducts({String? occasion,String? category}) async {
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
