import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutDataSource)
class CheckoutDataSourceImp extends CheckoutDataSource {
  ApiClient apiClient;
  CheckoutDataSourceImp(this.apiClient);
  @override
  Future<ApiResult<CashOrderResponse>?> cashOrder(String token) {
    return safeApiCall(call: () => apiClient.cashOrder(token));
  }

  @override
  Future<ApiResult<AddressResponse>?> getAddress(String token) {
    return safeApiCall(call: () => apiClient.address(token));
  }
}
