import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/driver_model.dart';
import 'package:flower_shop/features/checkout/data/models/response/order_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutDataSource)
class CheckoutDataSourceImp extends CheckoutDataSource {
  final ApiClient apiClient;
  final FirebaseFirestore firestore;

  CheckoutDataSourceImp(this.apiClient, this.firestore);

  @override
  Future<ApiResult<CashOrderResponse>?> cashOrder(String token) {
    return safeApiCall(call: () => apiClient.cashOrder(token));
  }

  @override
  Future<ApiResult<AddressCheckOutResponse>?> getAddress(String token) {
    return safeApiCall(call: () => apiClient.address(token));
  }

  @override
  Future<OrderModel?> getOrder(String orderId) async {
    try {
      final doc = await firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return OrderModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DriverModel?> getDriver(String driverId) async {
    try {
      final doc = await firestore.collection('drivers').doc(driverId).get();
      if (doc.exists) {
        return DriverModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
