sealed class TrackOrderMapIntent {}

class LoadMapDataIntent extends TrackOrderMapIntent {
  final String orderId;
  final String driverId;

  LoadMapDataIntent({required this.orderId, required this.driverId});
}

class UpdateDriverLocationIntent extends TrackOrderMapIntent {
  final double lat;
  final double lng;

  UpdateDriverLocationIntent(this.lat, this.lng);
}
