sealed class TrackOrderIntents {}

/// Start listening to the real-time order stream for [orderId]
class LoadOrderIntent extends TrackOrderIntents {
  final String orderId;
  LoadOrderIntent(this.orderId);
}

/// User tapped "Show map" button
class ShowMapIntent extends TrackOrderIntents {}
