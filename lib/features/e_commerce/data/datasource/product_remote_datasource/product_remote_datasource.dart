import '../../../../../app/core/network/api_result.dart';
import '../../models/response/products_response.dart';

abstract class ProductRemoteDatasource {
  Future<ApiResult<ProductsResponse>> getProduct({String? occasion});
}
