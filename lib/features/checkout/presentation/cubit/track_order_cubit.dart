import 'package:bloc/bloc.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_order_usecase.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetOrderUseCase _getOrderUseCase;
  final GetDriverUseCase _getDriverUseCase;

  TrackOrderCubit(this._getOrderUseCase, this._getDriverUseCase)
    : super(_initial());

  // ---------------------------------------------------------------------------
  // Initial / default state
  // ---------------------------------------------------------------------------
  static TrackOrderState _initial() {
    return const TrackOrderState(
      isLoading: false,
      estimatedArrival: '03 Sep 2024, 11:00 AM',
      driverName: 'Muhamed',
      driverSubtitle: 'Is your delivery hero for today',
      driverPhone: '+201000000000',
      driverWhatsapp: '+201000000000',
      steps: [
        TrackStep(
          title: 'Received your order',
          subtitle: '03 Sep 2024 - 2:10',
          isDone: true,
          isActive: true,
        ),
        TrackStep(
          title: 'Preparing your order',
          subtitle: '03 Sep 2024 - 2:10',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Out for delivery',
          subtitle: '03 Sep 2024 - 2:10',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Delivered',
          subtitle: '03 Sep 2024 - 2:10',
          isDone: false,
          isActive: false,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Intent dispatcher
  // ---------------------------------------------------------------------------
  void doIntent(TrackOrderIntents intent) {
    switch (intent) {
      case LoadOrderIntent():
        _loadOrder(intent.orderId);
      case SetCurrentStepIntent():
        _setCurrentStep(intent.stepIndex);
      case MarkDeliveredIntent():
        _setCurrentStep(state.steps.length - 1);
      case ShowMapIntent():
        // Navigation handled in the UI layer (listener)
        break;
    }
  }

  // ---------------------------------------------------------------------------
  // Private methods
  // ---------------------------------------------------------------------------

  /// Loads order data from the backend.
  /// TODO: inject & call a real repository once the API is ready.
  Future<void> _loadOrder(String orderId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final orderResult = await _getOrderUseCase.execute(orderId);

      switch (orderResult) {
        case SuccessApiResult(:final data):
          final order = data;
          // Update state with order data
          emit(
            state.copyWith(
              estimatedArrival: 'Today at 6:00 PM', // Fallback or dynamic
              // Map order status to steps here if needed
            ),
          );

          // Fetch driver details if driverId is present
          if (order.driverId.isNotEmpty) {
            final driverResult = await _getDriverUseCase.execute(
              order.driverId,
            );
            switch (driverResult) {
              case SuccessApiResult(:final data):
                final driver = data;
                emit(
                  state.copyWith(
                    driverName: driver.name,
                    driverPhone: driver.phone,
                    driverWhatsapp: driver.phone,
                    isLoading: false,
                  ),
                );
              case ErrorApiResult(:final error):
                emit(state.copyWith(isLoading: false, errorMessage: error));
            }
          } else {
            emit(state.copyWith(isLoading: false));
          }
        case ErrorApiResult(:final error):
          emit(state.copyWith(isLoading: false, errorMessage: error));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Advances the timeline: marks steps before [index] as done,
  /// step at [index] as active, and steps after [index] as pending.
  void _setCurrentStep(int index) {
    if (index < 0 || index >= state.steps.length) return;

    final updated = List.generate(state.steps.length, (i) {
      return state.steps[i].copyWith(isDone: i < index, isActive: i == index);
    });

    emit(state.copyWith(steps: updated));
  }
}
