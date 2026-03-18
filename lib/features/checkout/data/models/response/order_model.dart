import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';

class OrderModel extends Equatable {
  final String driverId;
  final OrderData orderData;
  final String status;
  final DateTime updatedAt;
  final UserAddress userAddress;
  final String userId;

  const OrderModel({
    required this.driverId,
    required this.orderData,
    required this.status,
    required this.updatedAt,
    required this.userAddress,
    required this.userId,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      driverId: data['driver_id'] ?? data['driverId'] ?? '',
      // Mapping 'oder_dt' from Firestore as per image
      orderData: OrderData.fromFirestore(data['oder_dt'] ?? {}),
      status: data['status'] ?? '',
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userAddress: UserAddress.fromFirestore(
        data['userAddress'] ?? data['user_address'] ?? {},
      ),
      userId: data['user_id'] ?? data['userId'] ?? '',
    );
  }

  OrderTracking toDomain() {
    return OrderTracking(
      driverId: driverId,
      status: status,
      updatedAt: updatedAt,
      userId: userId,
      orderData: orderData.toDomain(),
      userAddress: userAddress.toDomain(),
    );
  }

  @override
  List<Object?> get props => [
    driverId,
    orderData,
    status,
    updatedAt,
    userAddress,
    userId,
  ];
}

class OrderData extends Equatable {
  final List<OrderItemModel> items;
  final String orderId;
  final PickupAddress pickupAddress;
  final double? pickupLat;
  final double? pickupLng;
  final String status;
  final double totalPrice;
  final String? userAddressPlaceholder;

  const OrderData({
    required this.items,
    required this.orderId,
    required this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    required this.status,
    required this.totalPrice,
    this.userAddressPlaceholder,
  });

  factory OrderData.fromFirestore(Map<String, dynamic> data) {
    return OrderData(
      items: (data['items'] as List? ?? [])
          .map((e) => OrderItemModel.fromFirestore(e as Map<String, dynamic>))
          .toList(),
      orderId: data['orderId'] ?? '',
      pickupAddress: PickupAddress.fromFirestore(data['pickupAddress'] ?? {}),
      pickupLat: (data['pickupLat'] as num?)?.toDouble(),
      pickupLng: (data['pickupLng'] as num?)?.toDouble(),
      status: data['status'] ?? '',
      totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
      userAddressPlaceholder: data['user_address'],
    );
  }

  OrderTrackingData toDomain() {
    return OrderTrackingData(
      items: items.map((e) => e.toDomain()).toList(),
      orderId: orderId,
      pickupAddress: pickupAddress.address,
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      status: status,
      totalPrice: totalPrice,
    );
  }

  @override
  List<Object?> get props => [
    items,
    orderId,
    pickupAddress,
    pickupLat,
    pickupLng,
    status,
    totalPrice,
    userAddressPlaceholder,
  ];
}

class OrderItemModel extends Equatable {
  final String image;
  final double price;
  final String productId;
  final int quantity;
  final String title;

  const OrderItemModel({
    required this.image,
    required this.price,
    required this.productId,
    required this.quantity,
    required this.title,
  });

  factory OrderItemModel.fromFirestore(Map<String, dynamic> data) {
    return OrderItemModel(
      image: data['image'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 0,
      title: data['title'] ?? '',
    );
  }

  OrderTrackingItem toDomain() {
    return OrderTrackingItem(
      image: image,
      price: price,
      productId: productId,
      quantity: quantity,
      title: title,
    );
  }

  @override
  List<Object?> get props => [image, price, productId, quantity, title];
}

class UserAddress extends Equatable {
  final String address;
  final String name;
  final String userId;
  final double? lat;
  final double? lng;

  const UserAddress({
    required this.address,
    required this.name,
    required this.userId,
    this.lat,
    this.lng,
  });

  factory UserAddress.fromFirestore(Map<String, dynamic> data) {
    return UserAddress(
      address: data['address'] ?? data['adress'] ?? '',
      name: data['name'] ?? '',
      userId: data['user_id'] ?? data['userId'] ?? '',
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
    );
  }

  OrderUserAddress toDomain() {
    return OrderUserAddress(address: address, name: name, lat: lat, lng: lng);
  }

  @override
  List<Object?> get props => [address, name, userId, lat, lng];
}

class PickupAddress extends Equatable {
  final String address;

  const PickupAddress({required this.address});

  factory PickupAddress.fromFirestore(Map<String, dynamic> data) {
    return PickupAddress(address: data['address'] ?? '');
  }

  @override
  List<Object?> get props => [address];
}
