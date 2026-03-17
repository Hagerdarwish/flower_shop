import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/models/driver.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';

abstract class CheckoutRepo {
  Future<ApiResult<CashOrderModel>> postCashOrder(String token);
  Future<ApiResult<List<AddressModel>>> getAddress(String token);
  Future<ApiResult<OrderTracking>> getOrder(String orderId);
  Future<ApiResult<Driver>> getDriver(String driverId);
  Stream<OrderTracking?> watchOrder(String orderId);
  Stream<Driver?> getDriverStream(String driverId);
}
