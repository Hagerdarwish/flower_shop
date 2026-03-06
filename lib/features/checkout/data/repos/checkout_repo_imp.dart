import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/models/driver.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepo)
class CheckoutRepoImpl implements CheckoutRepo {
  final CheckoutDataSource checkoutDataSource;

  CheckoutRepoImpl({required this.checkoutDataSource});

  @override
  Future<ApiResult<CashOrderModel>> postCashOrder(String token) async {
    final result = await checkoutDataSource.cashOrder(token);

    if (result is SuccessApiResult<CashOrderResponse>) {
      return SuccessApiResult(data: result.data.toDomain());
    } else if (result is ErrorApiResult<CashOrderResponse>) {
      return ErrorApiResult(error: result.error);
    } else {
      return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<List<AddressModel>>> getAddress(String token) async {
    final result = await checkoutDataSource.getAddress(token);

    if (result is SuccessApiResult<AddressCheckOutResponse>) {
      return SuccessApiResult(data: result.data.toDomain());
    } else if (result is ErrorApiResult<AddressCheckOutResponse>) {
      return ErrorApiResult(error: result.error);
    } else {
      return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<OrderTracking>> getOrder(String orderId) async {
    try {
      final result = await checkoutDataSource.getOrder(orderId);
      if (result != null) {
        return SuccessApiResult(data: result.toDomain());
      } else {
        return ErrorApiResult(error: 'Order not found');
      }
    } catch (e) {
      return ErrorApiResult(error: e.toString());
    }
  }

  @override
  Future<ApiResult<Driver>> getDriver(String driverId) async {
    try {
      final result = await checkoutDataSource.getDriver(driverId);
      if (result != null) {
        return SuccessApiResult(data: result.toDomain());
      } else {
        return ErrorApiResult(error: 'Driver not found');
      }
    } catch (e) {
      return ErrorApiResult(error: e.toString());
    }
  }

  @override
  @override
  Stream<Driver?> getDriverStream(String driverId) {
    return checkoutDataSource
        .getDriverStream(driverId)
        .map((driverModel) => driverModel?.toDomain());
  }
}
