import 'dart:async';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_stream_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_intent.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_order_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/send_device_notification_usecase.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

@injectable
class TrackOrderMapCubit extends Cubit<TrackOrderMapState> {
  final GetOrderUseCase _getOrderUseCase;
  final GetDriverUseCase _getDriverUseCase;
  final GetDriverStreamUseCase _getDriverStreamUseCase;
  final SendDeviceNotificationUsecase _sendDeviceNotificationUsecase;

  StreamSubscription? _driverSubscription;
  Timer? _dummyTimer;

  TrackOrderMapCubit(
    this._getOrderUseCase,
    this._getDriverUseCase,
    this._getDriverStreamUseCase,
    this._sendDeviceNotificationUsecase,
  ) : super(TrackOrderMapState());

  void doIntent(TrackOrderMapIntent intent) {
    switch (intent) {
      case LoadMapDataIntent data:
        _loadMapData(orderId: data.orderId, driverId: data.driverId);
        break;

      case UpdateDriverLocationIntent data:
        _updateDriverLocation(data.lat, data.lng);
        break;

      case NotifyDriverOrderReceivedIntent():
        _notifyDriverOrderReceived();
        break;
    }
  }

  Future<void> _notifyDriverOrderReceived() async {
    final order = state.orderResource.data;
    if (order == null) return;

    final driverId = order.driverId;
    if (driverId.isEmpty) return;

    await _sendDeviceNotificationUsecase(
      SendDeviceNotificationParams(
        userId: driverId,
        title: "Order Confirmed 🎉",
        body: "our order has been received successfully",
      ),
    );
  }

  Future<geocoding.Location> _getLocationFromAddress(String address) async {
    if (address.trim().isEmpty) {
      throw Exception('Address is empty');
    }
    final locations = await geocoding.locationFromAddress(address);
    return locations.first;
  }

  Future<void> _loadMapData({
    required String orderId,
    required String driverId,
  }) async {
    emit(state.copyWith(orderResource: Resource.loading()));

    try {
      final orderResult = await _getOrderUseCase.execute(orderId);

      if (orderResult case SuccessApiResult(:final data)) {
        print(
          '///////////////////////////////////Firebase Order Data ///////////////////////////////',
        );
        print(data.toString());
        final driverResult = await _getDriverUseCase.execute(driverId);
        final order = data;

        double shopLat = data.orderData.pickupLat ?? 30.0444;
        double shopLng = data.orderData.pickupLng ?? 31.2357;

        if (data.orderData.pickupLat == null) {
          try {
            final shopLocation = await _getLocationFromAddress(
              order.orderData.pickupAddress,
            );
            shopLat = shopLocation.latitude;
            shopLng = shopLocation.longitude;
          } catch (e) {
            print('Error getting shop location from address: $e');
            shopLat = 30.0444;
            shopLng = 31.2357;
          }
        }

        double customerLat = data.userAddress.lat ?? 30.0514;
        double customerLng = data.userAddress.lng ?? 31.2457;

        if (data.userAddress.lat == null) {
          try {
            final customerLocation = await _getLocationFromAddress(
              order.userAddress.address,
            );
            customerLat = customerLocation.latitude;
            customerLng = customerLocation.longitude;
          } catch (e) {
            print('Error getting customer location from address: $e');
            customerLat = 30.0514;
            customerLng = 31.2457;
          }
        }

        double dLat = shopLat;
        double dLng = shopLng;

        String? driverName;
        bool shouldStartSimulation = true;

        if (driverResult case SuccessApiResult(:final data)) {
          print(
            '/////////////////////Firebase Initial Driver Data//////////////////',
          );
          print(data.toString());
          driverName = data.name;

          if (data.currentLocation.lat != 0.0) {
            dLat = data.currentLocation.lat;
            dLng = data.currentLocation.lng;
            shouldStartSimulation = false;
          }
        }

        if (shouldStartSimulation) {
          _startDummyDriverAnimation(
            shopLat,
            shopLng,
            customerLat,
            customerLng,
          );
        }

        emit(
          state.copyWith(
            orderResource: Resource.success(order),
            driverLat: dLat,
            driverLng: dLng,
            shopLat: shopLat,
            shopLng: shopLng,
            customerLat: customerLat,
            customerLng: customerLng,
            driverName: driverName,
          ),
        );

        _subscribeToDriver(driverId: driverId);
      } else if (orderResult case ErrorApiResult(:final error)) {
        emit(state.copyWith(orderResource: Resource.error(error)));
      }
    } catch (e) {
      emit(state.copyWith(orderResource: Resource.error(e.toString())));
    }
  }

  void _startDummyDriverAnimation(
    double shopLat,
    double shopLng,
    double customerLat,
    double customerLng,
  ) {
    _dummyTimer?.cancel();
    double stepRatio = 0.0;

    _dummyTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (stepRatio >= 1.0) {
        timer.cancel();
        return;
      }
      stepRatio += 0.005;
      if (stepRatio > 1.0) stepRatio = 1.0;

      double currentLat;
      double currentLng;

      if (stepRatio <= 0.33) {
        double segRatio = stepRatio / 0.33;
        currentLat = shopLat + (customerLat - shopLat) * 0.5 * segRatio;
        currentLng = shopLng;
      } else if (stepRatio <= 0.66) {
        double segRatio = (stepRatio - 0.33) / 0.33;
        currentLat = shopLat + (customerLat - shopLat) * 0.5;
        currentLng = shopLng + (customerLng - shopLng) * segRatio;
      } else {
        double segRatio = (stepRatio - 0.66) / 0.34;
        currentLat =
            (shopLat + (customerLat - shopLat) * 0.5) +
            (customerLat - (shopLat + (customerLat - shopLat) * 0.5)) *
                segRatio;
        currentLng = customerLng;
      }

      _updateDriverLocation(currentLat, currentLng);
    });
  }

  void _updateDriverLocation(double lat, double lng) {
    emit(state.copyWith(driverLat: lat, driverLng: lng));
  }

  void _subscribeToDriver({required String driverId}) {
    _driverSubscription?.cancel();

    _driverSubscription = _getDriverStreamUseCase.execute(driverId).listen((
      driver,
    ) {
      print('======== Firebase Stream Driver Update ========');
      print(driver?.toString());
      if (driver != null && driver.currentLocation.lat != 0.0) {
        _dummyTimer?.cancel();
        _updateDriverLocation(
          driver.currentLocation.lat,
          driver.currentLocation.lng,
        );
      }
    });
  }

  @override
  Future<void> close() {
    _driverSubscription?.cancel();
    _dummyTimer?.cancel();
    return super.close();
  }
}
