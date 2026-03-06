// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_intent.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:flower_shop/app/core/network/api_result.dart';
// import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
// import 'package:flower_shop/features/checkout/domain/usecases/get_order_usecase.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;

// @injectable
// class TrackOrderMapCubit extends Cubit<TrackOrderMapState> {
//   final GetOrderUseCase _getOrderUseCase;
//   final GetDriverUseCase _getDriverUseCase;

//   TrackOrderMapCubit(this._getOrderUseCase, this._getDriverUseCase)
//     : super(TrackOrderMapState());

//   void doIntent(TrackOrderMapIntent intent) {
//     switch (intent.runtimeType) {
//       case LoadMapDataIntent:
//         final data = intent as LoadMapDataIntent;
//         _loadMapData(orderId: data.orderId, driverId: data.driverId);
//         break;

//       case UpdateDriverLocationIntent:
//         final data = intent as UpdateDriverLocationIntent;
//         _updateDriverLocation(data.lat, data.lng);
//         break;
//     }
//   }

//   Future<geocoding.Location> _getLocationFromAddress(String address) async {
//     List<geocoding.Location> locations = await geocoding.locationFromAddress(
//       address,
//     );
//     return locations.first;
//   }

//   Future<void> _loadMapData({
//     required String orderId,
//     required String driverId,
//   }) async {
//     emit(state.copyWith(isLoading: true));

//     try {
//       final orderResult = await _getOrderUseCase.execute(orderId);

//       switch (orderResult) {
//         case SuccessApiResult(:final data):
//           final order = data;

//           final driverResult = await _getDriverUseCase.execute(driverId);

//           switch (driverResult) {
//             case SuccessApiResult(:final data):
//               final driver = data;

//               final shopLocation = await _getLocationFromAddress(
//                 order.orderData.pickupAddress,
//               );
//               final customerLocation = await _getLocationFromAddress(
//                 order.userAddress.address,
//               );

//               emit(
//                 state.copyWith(
//                   isLoading: false,
//                   driverLat: driver.currentLocation.lat,
//                   driverLng: driver.currentLocation.lng,
//                   shopLat: shopLocation.latitude,
//                   shopLng: shopLocation.longitude,
//                   customerLat: customerLocation.latitude,
//                   customerLng: customerLocation.longitude,
//                 ),
//               );

//             case ErrorApiResult(:final error):
//               emit(state.copyWith(isLoading: false, errorMessage: error));
//           }

//         case ErrorApiResult(:final error):
//           emit(state.copyWith(isLoading: false, errorMessage: error));
//       }
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
//     }
//   }

//   void _updateDriverLocation(double lat, double lng) {
//     emit(state.copyWith(driverLat: lat, driverLng: lng));
//   }
// }

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_order_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_intent.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

@injectable
class TrackOrderMapCubit extends Cubit<TrackOrderMapState> {
  final GetOrderUseCase _getOrderUseCase;
  final GetDriverUseCase _getDriverUseCase;

  TrackOrderMapCubit(this._getOrderUseCase, this._getDriverUseCase)
    : super(TrackOrderMapState());

  void doIntent(TrackOrderMapIntent intent) {
    switch (intent.runtimeType) {
      case LoadMapDataIntent:
        final data = intent as LoadMapDataIntent;
        _loadMapData(orderId: data.orderId, driverId: data.driverId);
        break;

      case UpdateDriverLocationIntent:
        final data = intent as UpdateDriverLocationIntent;
        _updateDriverLocation(data.lat, data.lng);
        break;
    }
  }

  Future<geocoding.Location> _getLocationFromAddress(String address) async {
    List<geocoding.Location> locations = await geocoding.locationFromAddress(
      address,
    );

    return locations.first;
  }

  Future<void> _loadMapData({
    required String orderId,
    required String driverId,
  }) async {
    emit(state.copyWith(orderResource: Resource.loading()));

    try {
      final orderResult = await _getOrderUseCase.execute(orderId);

      switch (orderResult) {
        case SuccessApiResult(:final data):
          final driverResult = await _getDriverUseCase.execute(driverId);

          switch (driverResult) {
            case SuccessApiResult(:final data):
              final order = orderResult.data;
              final driver = driverResult.data;

              final shopLocation = await _getLocationFromAddress(
                order.orderData.pickupAddress,
              );

              final customerLocation = await _getLocationFromAddress(
                order.userAddress.address,
              );

              emit(
                state.copyWith(
                  orderResource: Resource.success(order),
                  driverLat: driver.currentLocation.lat,
                  driverLng: driver.currentLocation.lng,
                  shopLat: shopLocation.latitude,
                  shopLng: shopLocation.longitude,
                  customerLat: customerLocation.latitude,
                  customerLng: customerLocation.longitude,
                ),
              );

            case ErrorApiResult(:final error):
              emit(state.copyWith(orderResource: Resource.error(error)));
          }

        case ErrorApiResult(:final error):
          emit(state.copyWith(orderResource: Resource.error(error)));
      }
    } catch (e) {
      emit(state.copyWith(orderResource: Resource.error(e.toString())));
    }
  }

  void _updateDriverLocation(double lat, double lng) {
    emit(state.copyWith(driverLat: lat, driverLng: lng));
  }
}
