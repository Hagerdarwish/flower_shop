import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/watch_order_usecase.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final WatchOrderUseCase _watchOrderUseCase;
  final GetDriverUseCase _getDriverUseCase;

  StreamSubscription? _orderSubscription;

  TrackOrderCubit(this._watchOrderUseCase, this._getDriverUseCase)
    : super(_initial());

  // ---------------------------------------------------------------------------
  // Initial / default state
  // ---------------------------------------------------------------------------
  static TrackOrderState _initial() {
    return const TrackOrderState(
      isLoading: true,
      estimatedArrival: '',
      driverName: '',
      driverSubtitle: 'Is your delivery hero for today',
      driverPhone: '',
      driverWhatsapp: '',
      driverId: '',
      steps: [
        TrackStep(
          title: 'Wait for driver',
          subtitle: '',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Confirmed',
          subtitle: '',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Picked up',
          subtitle: '',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Out for delivery',
          subtitle: '',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Arrived',
          subtitle: '',
          isDone: false,
          isActive: false,
        ),
        TrackStep(
          title: 'Delivered',
          subtitle: '',
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
        _subscribeToOrder(intent.orderId);
      case ShowMapIntent():
        // Navigation handled in the UI layer (listener)
        break;
    }
  }

  Stream getOrderStream(String orderId) => _watchOrderUseCase.execute(orderId);
  // ---------------------------------------------------------------------------
  // Private methods
  // ---------------------------------------------------------------------------

  /// Subscribes to the real-time Firestore stream for this order.
  /// Any document change automatically triggers a state rebuild.
  void _subscribeToOrder(String orderId) {
    _orderSubscription?.cancel();
    emit(state.copyWith(isLoading: true, errorMessage: null));

    _orderSubscription = _watchOrderUseCase
        .execute(orderId)
        .listen(
          (order) async {
            if (order == null) {
              emit(
                state.copyWith(
                  isLoading: false,
                  errorMessage: 'Order not found',
                ),
              );
              return;
            }

            // Map status → step and update arrival
            _setCurrentStep(_statusToStepIndex(order.orderData.status));
            final formattedDate = DateFormat(
              'dd MMM yyyy, hh:mm a',
            ).format(order.updatedAt);
            emit(
              state.copyWith(
                isLoading: false,
                estimatedArrival: formattedDate,
                driverId: order.driverId,
              ),
            );

            if (order.driverId.isNotEmpty) {
              final driverResult = await _getDriverUseCase.execute(
                order.driverId,
              );
              switch (driverResult) {
                case SuccessApiResult(:final data):
                  emit(
                    state.copyWith(
                      driverName: data.name,
                      driverPhone: data.phone,
                      driverWhatsapp: data.phone,
                    ),
                  );
                case ErrorApiResult():
                  break; // Keep previous driver info on error
              }
            }
          },
          onError: (e) {
            emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
          },
        );
  }

  void _setCurrentStep(int index) {
    if (index < 0 || index >= state.steps.length) return;

    final updated = List.generate(state.steps.length, (i) {
      return state.steps[i].copyWith(isDone: i < index, isActive: i == index);
    });

    emit(state.copyWith(steps: updated));
  }

  int _statusToStepIndex(String status) {
    switch (status.toLowerCase().trim()) {
      case 'wait_for_driver':
        return 0;
      case 'pending':
        return 1;
      case 'picked':
        return 2;
      case 'out_for_delivery':
        return 3;
      case 'arrived':
        return 4;
      case 'delivered':
        return 5;
      default:
        return 0;
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
