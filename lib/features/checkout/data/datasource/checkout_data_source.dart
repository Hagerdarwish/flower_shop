import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';

import '../models/response/address_check_out_response.dart';
import '../models/response/order_model.dart';
import '../models/response/driver_model.dart';

abstract class CheckoutDataSource {
  Future<ApiResult<CashOrderResponse>?> cashOrder(String token);
  Future<ApiResult<AddressCheckOutResponse>?> getAddress(String token);
  Future<OrderModel?> getOrder(String orderId);
  Future<DriverModel?> getDriver(String driverId);
  Stream<OrderModel?> watchOrder(String orderId);
  Future<void> seedOrderTracking(CashOrderModel order);
  Stream<DriverModel?> getDriverStream(String driverId);
}
