import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';

import '../models/response/address_check_out_response.dart';

abstract class CheckoutDataSource {
  Future<ApiResult<CashOrderResponse>?> cashOrder(String token);
  Future<ApiResult<AddressCheckOutResponse>?> getAddress(String token);
}
