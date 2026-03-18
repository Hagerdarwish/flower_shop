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
import 'package:geocoding/geocoding.dart' as geocoding;

@injectable
class TrackOrderMapCubit extends Cubit<TrackOrderMapState> {
  final GetOrderUseCase _getOrderUseCase;
  final GetDriverUseCase _getDriverUseCase;
  final GetDriverStreamUseCase _getDriverStreamUseCase;

  StreamSubscription? _driverSubscription;

  TrackOrderMapCubit(
    this._getOrderUseCase,
    this._getDriverUseCase,
    this._getDriverStreamUseCase,
  ) : super(TrackOrderMapState());

  void doIntent(TrackOrderMapIntent intent) {
    switch (intent) {
      case LoadMapDataIntent data:
        _loadMapData(orderId: data.orderId, driverId: data.driverId);
        break;

      case UpdateDriverLocationIntent data:
        _updateDriverLocation(data.lat, data.lng);
        break;
    }
  }

  Future<geocoding.Location> _getLocationFromAddress(String address) async {
    if (address.trim().isEmpty) {
      throw Exception('Address is empty');
    }
    final locations = await geocoding.locationFromAddress(address);
    return locations.first;
  }

  Timer? _dummyTimer;

  Future<void> _loadMapData({
    required String orderId,
    required String driverId,
  }) async {
    emit(state.copyWith(orderResource: Resource.loading()));

    try {
      final orderResult = await _getOrderUseCase.execute(orderId);

      if (orderResult case SuccessApiResult(:final data)) {
        print('======== Firebase Order Data ========');
        print(data.toString());
        final driverResult = await _getDriverUseCase.execute(driverId);
        final order = data;

        double shopLat = 30.0444;
        double shopLng = 31.2357;

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

        double customerLat = 30.0514;
        double customerLng = 31.2457;

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

        // Always start driver at shop for the simulation to show movement between two locations
        double dLat = shopLat;
        double dLng = shopLng;

        String? driverName;

        if (driverResult case SuccessApiResult(:final data)) {
          print('======== Firebase Initial Driver Data ========');
          print(data.toString());
          driverName = data.name;
        }

        _startDummyDriverAnimation(shopLat, shopLng, customerLat, customerLng);

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

        // Start subscription only AFTER the initial state with shop/customer is emitted
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

    // Smoother animation: 100ms per step, total ~10 seconds
    _dummyTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (stepRatio >= 1.0) {
        timer.cancel();
        return;
      }
      stepRatio += 0.01;
      if (stepRatio > 1.0) {
        stepRatio = 1.0;
      }

      // Linear interpolation between shop and customer
      double currentLat = shopLat + (customerLat - shopLat) * stepRatio;
      double currentLng = shopLng + (customerLng - shopLng) * stepRatio;

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
        // Commenting out real-time updates to keep the driver on the path simulation
        /*
        _dummyTimer?.cancel();
        _updateDriverLocation(
          driver.currentLocation.lat,
          driver.currentLocation.lng,
        );
        */
      }
    });
  }

  @override
  Future<void> close() {
    _driverSubscription?.cancel();
    return super.close();
  }
}
