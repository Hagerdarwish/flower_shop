import 'package:equatable/equatable.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';

class TrackOrderState extends Equatable {
  const TrackOrderState({
    required this.isLoading,
    required this.estimatedArrival,
    required this.driverName,
    required this.driverSubtitle,
    required this.driverPhone,
    required this.driverWhatsapp,
    required this.driverId,
    required this.steps,
    this.errorMessage,
  });

  final bool isLoading;
  final String estimatedArrival;
  final String driverName;
  final String driverSubtitle;
  final String driverPhone;
  final String driverWhatsapp;
  final String driverId;
  final List<TrackStep> steps;
  final String? errorMessage;

  /// Convenience: returns the index of the currently active step, or -1.
  int get activeStepIndex => steps.indexWhere((s) => s.isActive);

  TrackOrderState copyWith({
    bool? isLoading,
    String? estimatedArrival,
    String? driverName,
    String? driverSubtitle,
    String? driverPhone,
    String? driverWhatsapp,
    String? driverId,
    List<TrackStep>? steps,
    String? errorMessage,
  }) {
    return TrackOrderState(
      isLoading: isLoading ?? this.isLoading,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
      driverName: driverName ?? this.driverName,
      driverSubtitle: driverSubtitle ?? this.driverSubtitle,
      driverPhone: driverPhone ?? this.driverPhone,
      driverWhatsapp: driverWhatsapp ?? this.driverWhatsapp,
      driverId: driverId ?? this.driverId,
      steps: steps ?? this.steps,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    estimatedArrival,
    driverName,
    driverSubtitle,
    driverPhone,
    driverWhatsapp,
    driverId,
    steps,
    errorMessage,
  ];
}
