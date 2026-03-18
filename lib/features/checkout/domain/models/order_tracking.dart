import 'package:equatable/equatable.dart';

class OrderTracking extends Equatable {
  final String driverId;
  final String status;
  final DateTime updatedAt;
  final String userId;
  final OrderTrackingData orderData;
  final OrderUserAddress userAddress;

  const OrderTracking({
    required this.driverId,
    required this.status,
    required this.updatedAt,
    required this.userId,
    required this.orderData,
    required this.userAddress,
  });

  @override
  List<Object?> get props => [
    driverId,
    status,
    updatedAt,
    userId,
    orderData,
    userAddress,
  ];
}

class OrderTrackingData extends Equatable {
  final List<OrderTrackingItem> items;
  final String orderId;
  final String pickupAddress;
  final double? pickupLat;
  final double? pickupLng;
  final String status;
  final double totalPrice;

  const OrderTrackingData({
    required this.items,
    required this.orderId,
    required this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    required this.status,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
    items,
    orderId,
    pickupAddress,
    pickupLat,
    pickupLng,
    status,
    totalPrice,
  ];
}

class OrderTrackingItem extends Equatable {
  final String image;
  final double price;
  final String productId;
  final int quantity;
  final String title;

  const OrderTrackingItem({
    required this.image,
    required this.price,
    required this.productId,
    required this.quantity,
    required this.title,
  });

  @override
  List<Object?> get props => [image, price, productId, quantity, title];
}

class OrderUserAddress extends Equatable {
  final String address;
  final String name;
  final double? lat;
  final double? lng;

  const OrderUserAddress({
    required this.address,
    required this.name,
    this.lat,
    this.lng,
  });

  @override
  List<Object?> get props => [address, name, lat, lng];
}
