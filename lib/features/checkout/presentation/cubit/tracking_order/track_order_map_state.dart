import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';

class TrackOrderMapState {
  final Resource<OrderTracking> orderResource;

  final double? driverLat;
  final double? driverLng;
  final double? shopLat;
  final double? shopLng;
  final double? customerLat;
  final double? customerLng;
  final String? driverName;

  TrackOrderMapState({
    Resource<OrderTracking>? orderResource,
    this.driverLat,
    this.driverLng,
    this.shopLat,
    this.shopLng,
    this.customerLat,
    this.customerLng,
    this.driverName,
  }) : orderResource = orderResource ?? Resource.initial();

  TrackOrderMapState copyWith({
    Resource<OrderTracking>? orderResource,
    double? driverLat,
    double? driverLng,
    double? shopLat,
    double? shopLng,
    double? customerLat,
    double? customerLng,
    String? driverName,
  }) {
    return TrackOrderMapState(
      orderResource: orderResource ?? this.orderResource,
      driverLat: driverLat ?? this.driverLat,
      driverLng: driverLng ?? this.driverLng,
      shopLat: shopLat ?? this.shopLat,
      shopLng: shopLng ?? this.shopLng,
      customerLat: customerLat ?? this.customerLat,
      customerLng: customerLng ?? this.customerLng,
      driverName: driverName ?? this.driverName,
    );
  }
}
