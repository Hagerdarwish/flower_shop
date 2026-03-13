import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/checkout/data/models/response/driver_model.dart';
import 'package:flower_shop/features/checkout/data/models/response/order_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:injectable/injectable.dart' hide Order;

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

  @override
  Stream<OrderModel?> watchOrder(String orderId) {
    return firestore
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((doc) => doc.exists ? OrderModel.fromFirestore(doc) : null);
  }

  @override
  Future<void> seedOrderTracking(CashOrderModel order) async {
    try {
      await firestore.collection('orders').doc(order.id).set({
        'driver_id': '',
        'updated_at': FieldValue.serverTimestamp(),
        'user_id': order.userId,
        'oder_dt': {
          'orderId': order.id,
          'totalPrice': order.totalPrice,
          'status': 'wait_for_driver',
          'items': order.items
              .map(
                (item) => {
                  'title': item.product.title,
                  'quantity': item.quantity,
                  'price': item.price,
                  'productId': item.product.id,
                  'image': item.product.imgCover,
                },
              )
              .toList(),
        },
      });
    } catch (e) {
      // Fail silently for seeding as it's an optimization
    }
  }

  @override
  Stream<DriverModel?> getDriverStream(String driverId) {
    try {
      return firestore.collection('drivers').doc(driverId).snapshots().map((
        doc,
      ) {
        if (doc.exists) {
          return DriverModel.fromFirestore(doc);
        }
        return null;
      });
    } catch (e) {
      return const Stream.empty();
    }
  }
}
