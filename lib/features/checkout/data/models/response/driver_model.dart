import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_shop/features/checkout/domain/models/driver.dart';

class DriverModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String deviceToken;
  final DriverLocationModel currentLocation;

  const DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.deviceToken,
    required this.currentLocation,
  });

  factory DriverModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DriverModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      deviceToken: data['deviceToken'] ?? '',
      currentLocation: DriverLocationModel.fromFirestore(
        data['currentLocation'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Driver toDomain() {
    return Driver(
      id: id,
      name: name,
      phone: phone,
      deviceToken: deviceToken,
      currentLocation: currentLocation.toDomain(),
    );
  }

  @override
  List<Object?> get props => [id, name, phone, deviceToken, currentLocation];
}

class DriverLocationModel extends Equatable {
  final double lat;
  final double lng;

  const DriverLocationModel({required this.lat, required this.lng});

  factory DriverLocationModel.fromFirestore(Map<String, dynamic> data) {
    return DriverLocationModel(
      lat: (data['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (data['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }

  DriverLocation toDomain() {
    return DriverLocation(lat: lat, lng: lng);
  }

  @override
  List<Object?> get props => [lat, lng];
}
