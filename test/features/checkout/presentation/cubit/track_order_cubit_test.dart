import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_order_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_state.dart';

class MockGetOrderUseCase extends Mock implements GetOrderUseCase {}

class MockGetDriverUseCase extends Mock implements GetDriverUseCase {}

/// Creates a minimal [OrderTracking] with the given [status].
OrderTracking _fakeOrder(String status) => OrderTracking(
  driverId: '',
  status: status,
  updatedAt: DateTime(2024),
  userId: 'user1',
  orderData: const OrderTrackingData(
    items: [],
    orderId: 'order1',
    pickupAddress: '',
    status: '',
    totalPrice: 0,
  ),
  userAddress: const OrderUserAddress(address: '', name: ''),
);

void main() {
  late TrackOrderCubit cubit;
  late MockGetOrderUseCase mockGetOrderUseCase;
  late MockGetDriverUseCase mockGetDriverUseCase;

  setUp(() {
    mockGetOrderUseCase = MockGetOrderUseCase();
    mockGetDriverUseCase = MockGetDriverUseCase();
    cubit = TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  // ───────────────────────────────────────────────────────────────
  // Initial state
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — initial state', () {
    test('initial state is not loading and has 4 steps', () {
      expect(cubit.state.isLoading, false);
      expect(cubit.state.steps.length, 4);
      expect(cubit.state.errorMessage, isNull);
    });

    test('first step is active in initial state', () {
      final state = cubit.state;
      expect(state.steps[0].isActive, true);
      expect(state.steps[0].isDone, true);
      expect(state.steps[1].isActive, false);
      expect(state.steps[1].isDone, false);
    });

    test('activeStepIndex returns 0 initially', () {
      expect(cubit.state.activeStepIndex, 0);
    });
  });

  // ───────────────────────────────────────────────────────────────
  // LoadOrderIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — LoadOrderIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'emits loading then loaded (isLoading false) on success',
      build: () {
        when(() => mockGetOrderUseCase.execute(any())).thenAnswer(
          (_) async => SuccessApiResult(data: _fakeOrder('pending')),
        );
        return TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase);
      },
      act: (c) => c.doIntent(LoadOrderIntent('order-123')),
      // The cubit emits 4 states: loading=true, steps updated,
      // estimatedArrival updated, loading=false. Skip to the final one.
      skip: 3,
      expect: () => [
        isA<TrackOrderState>().having((s) => s.isLoading, 'isLoading', false),
      ],
    );
  });

  // ───────────────────────────────────────────────────────────────
  // SetCurrentStepIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — SetCurrentStepIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'step 0: first step active, none done',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(SetCurrentStepIntent(0)),
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.steps[0].isActive, 'step0 active', true)
            .having((s) => s.steps[0].isDone, 'step0 done', false),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'step 2: steps 0 and 1 are done, step 2 is active',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(SetCurrentStepIntent(2)),
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.steps[0].isDone, 'step0 done', true)
            .having((s) => s.steps[0].isActive, 'step0 active', false)
            .having((s) => s.steps[1].isDone, 'step1 done', true)
            .having((s) => s.steps[1].isActive, 'step1 active', false)
            .having((s) => s.steps[2].isActive, 'step2 active', true)
            .having((s) => s.steps[2].isDone, 'step2 done', false)
            .having((s) => s.steps[3].isDone, 'step3 done', false),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'out-of-bounds index emits nothing',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(SetCurrentStepIntent(99)),
      expect: () => [],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'negative index emits nothing',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(SetCurrentStepIntent(-1)),
      expect: () => [],
    );
  });

  // ───────────────────────────────────────────────────────────────
  // MarkDeliveredIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — MarkDeliveredIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'last step (index 3) becomes active, all previous are done',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(MarkDeliveredIntent()),
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.steps[0].isDone, 'step0 done', true)
            .having((s) => s.steps[1].isDone, 'step1 done', true)
            .having((s) => s.steps[2].isDone, 'step2 done', true)
            .having((s) => s.steps[3].isActive, 'step3 active', true)
            .having((s) => s.steps[3].isDone, 'step3 done', false),
      ],
    );
  });

  // ───────────────────────────────────────────────────────────────
  // ShowMapIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — ShowMapIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'emits nothing (navigation handled by UI)',
      build: () => TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase),
      act: (c) => c.doIntent(ShowMapIntent()),
      expect: () => [],
    );
  });

  // ───────────────────────────────────────────────────────────────
  // TrackStep model
  // ───────────────────────────────────────────────────────────────
  group('TrackStep — model', () {
    const step = TrackStep(
      title: 'Test',
      subtitle: '01 Jan',
      isDone: false,
      isActive: true,
    );

    test('copyWith updates only given fields', () {
      final updated = step.copyWith(isDone: true);
      expect(updated.isDone, true);
      expect(updated.isActive, true);
      expect(updated.title, 'Test');
    });

    test('equality works correctly', () {
      const same = TrackStep(
        title: 'Test',
        subtitle: '01 Jan',
        isDone: false,
        isActive: true,
      );
      expect(step, equals(same));
    });
  });

  // ───────────────────────────────────────────────────────────────
  // TrackOrderState — model
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderState — model', () {
    test('copyWith preserves existing fields', () {
      final original = cubit.state;
      final updated = original.copyWith(estimatedArrival: 'Tomorrow');
      expect(updated.estimatedArrival, 'Tomorrow');
      expect(updated.driverName, original.driverName);
      expect(updated.steps, original.steps);
    });

    test('activeStepIndex returns -1 when no step is active', () {
      const state = TrackOrderState(
        isLoading: false,
        estimatedArrival: '',
        driverName: '',
        driverSubtitle: '',
        driverPhone: '',
        driverWhatsapp: '',
        steps: [
          TrackStep(title: 'A', subtitle: '', isDone: false, isActive: false),
        ],
      );
      expect(state.activeStepIndex, -1);
    });
  });

  // ───────────────────────────────────────────────────────────────
  // _statusToStepIndex — via LoadOrderIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — _statusToStepIndex', () {
    /// Builds a cubit stubbed to return an order with [status].
    TrackOrderCubit _buildCubit(String status) {
      when(
        () => mockGetOrderUseCase.execute(any()),
      ).thenAnswer((_) async => SuccessApiResult(data: _fakeOrder(status)));
      return TrackOrderCubit(mockGetOrderUseCase, mockGetDriverUseCase);
    }

    blocTest<TrackOrderCubit, TrackOrderState>(
      'status "pending" → step 0 (Received) is active',
      build: () => _buildCubit('pending'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      // The cubit emits 4 states; skip the first 3 intermediate ones
      // and only assert the final settled state.
      skip: 3,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isActive, 'step0 active', true)
            .having((s) => s.steps[1].isActive, 'step1 active', false),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'status "preparing" → step 1 (Preparing) is active',
      build: () => _buildCubit('preparing'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 3,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isDone, 'step0 done', true)
            .having((s) => s.steps[1].isActive, 'step1 active', true)
            .having((s) => s.steps[2].isActive, 'step2 active', false),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'status "out_for_delivery" → step 2 (Out for delivery) is active',
      build: () => _buildCubit('out_for_delivery'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 3,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isDone, 'step0 done', true)
            .having((s) => s.steps[1].isDone, 'step1 done', true)
            .having((s) => s.steps[2].isActive, 'step2 active', true)
            .having((s) => s.steps[3].isActive, 'step3 active', false),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'status "delivered" → step 3 (Delivered) is active',
      build: () => _buildCubit('delivered'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 3,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isDone, 'step0 done', true)
            .having((s) => s.steps[1].isDone, 'step1 done', true)
            .having((s) => s.steps[2].isDone, 'step2 done', true)
            .having((s) => s.steps[3].isActive, 'step3 active', true),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'unknown status fallback → step 0 active',
      build: () => _buildCubit('unknown_status'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 3,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isActive, 'step0 active', true),
      ],
    );
  });
}
