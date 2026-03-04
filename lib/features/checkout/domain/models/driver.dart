import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String deviceToken;
  final DriverLocation currentLocation;

  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.deviceToken,
    required this.currentLocation,
  });

  @override
  List<Object?> get props => [id, name, phone, deviceToken, currentLocation];
}

class DriverLocation extends Equatable {
  final double lat;
  final double lng;

  const DriverLocation({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
