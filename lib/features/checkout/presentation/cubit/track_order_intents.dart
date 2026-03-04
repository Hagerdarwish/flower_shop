sealed class TrackOrderIntents {}

/// Load / refresh order tracking data for [orderId]
class LoadOrderIntent extends TrackOrderIntents {
  final String orderId;
  LoadOrderIntent(this.orderId);
}

/// Advance the timeline to [stepIndex] (marks previous steps as done)
class SetCurrentStepIntent extends TrackOrderIntents {
  final int stepIndex;
  SetCurrentStepIntent(this.stepIndex);
}

/// Convenience intent: mark the last step (Delivered) as active
class MarkDeliveredIntent extends TrackOrderIntents {}

/// User tapped "Show map" button
class ShowMapIntent extends TrackOrderIntents {}
