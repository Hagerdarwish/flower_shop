import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';

abstract class CheckoutRepo {
  Future<ApiResult<CashOrderModel>> postCashOrder(String token);
  Future<ApiResult<List<AddressModel>>> getAddress(String token);
}
