class TrackOrderMapState {
  final bool isLoading;
  final double? driverLat;
  final double? driverLng;
  final double? shopLat;
  final double? shopLng;
  final double? customerLat;
  final double? customerLng;

  final String? errorMessage;

  TrackOrderMapState({
    this.isLoading = false,
    this.driverLat,
    this.driverLng,
    this.shopLat,
    this.shopLng,
    this.customerLat,
    this.customerLng,
    this.errorMessage,
  });

  TrackOrderMapState copyWith({
    bool? isLoading,
    double? driverLat,
    double? driverLng,
    double? shopLat,
    double? shopLng,
    double? customerLat,
    double? customerLng,
    String? errorMessage,
  }) {
    return TrackOrderMapState(
      isLoading: isLoading ?? this.isLoading,
      driverLat: driverLat ?? this.driverLat,
      driverLng: driverLng ?? this.driverLng,
      shopLat: shopLat ?? this.shopLat,
      shopLng: shopLng ?? this.shopLng,
      customerLat: customerLat ?? this.customerLat,
      customerLng: customerLng ?? this.customerLng,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
