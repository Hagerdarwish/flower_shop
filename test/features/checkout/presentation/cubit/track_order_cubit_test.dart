import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flower_shop/features/checkout/domain/models/order_tracking.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_driver_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/watch_order_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_state.dart';

class MockWatchOrderUseCase extends Mock implements WatchOrderUseCase {}

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
  late MockWatchOrderUseCase mockWatchOrderUseCase;
  late MockGetDriverUseCase mockGetDriverUseCase;

  setUp(() {
    mockWatchOrderUseCase = MockWatchOrderUseCase();
    mockGetDriverUseCase = MockGetDriverUseCase();
    cubit = TrackOrderCubit(mockWatchOrderUseCase, mockGetDriverUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  // ───────────────────────────────────────────────────────────────
  // Initial state
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — initial state', () {
    test('initial state is loading and has 6 steps', () {
      expect(cubit.state.isLoading, true);
      expect(cubit.state.steps.length, 6);
      expect(cubit.state.errorMessage, isNull);
    });

    test('no step is active or done in initial state', () {
      final state = cubit.state;
      for (var step in state.steps) {
        expect(step.isActive, false);
        expect(step.isDone, false);
      }
    });

    test('activeStepIndex returns -1 initially', () {
      expect(cubit.state.activeStepIndex, -1);
    });
  });

  // ───────────────────────────────────────────────────────────────
  // LoadOrderIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — LoadOrderIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'emits loading then updated state when stream emits order',
      build: () {
        when(
          () => mockWatchOrderUseCase.execute(any()),
        ).thenAnswer((_) => Stream.value(_fakeOrder('pending')));
        return TrackOrderCubit(mockWatchOrderUseCase, mockGetDriverUseCase);
      },
      act: (c) => c.doIntent(LoadOrderIntent('order-123')),
      skip: 2,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having(
              (s) => s.estimatedArrival,
              'estimatedArrival',
              '01 Jan 2024, 12:00 AM',
            )
            .having((s) => s.steps[1].isActive, 'step1 (pending) active', true),
      ],
    );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'emits error when order is not found (null from stream)',
      build: () {
        when(
          () => mockWatchOrderUseCase.execute(any()),
        ).thenAnswer((_) => Stream.value(null));
        return TrackOrderCubit(mockWatchOrderUseCase, mockGetDriverUseCase);
      },
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 1,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.errorMessage, 'error message', 'Order not found'),
      ],
    );
  });

  // ───────────────────────────────────────────────────────────────
  // ShowMapIntent
  // ───────────────────────────────────────────────────────────────
  group('TrackOrderCubit — ShowMapIntent', () {
    blocTest<TrackOrderCubit, TrackOrderState>(
      'emits nothing (navigation handled by UI)',
      build: () => TrackOrderCubit(mockWatchOrderUseCase, mockGetDriverUseCase),
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
        driverId: '',
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
        () => mockWatchOrderUseCase.execute(any()),
      ).thenAnswer((_) => Stream.value(_fakeOrder(status)));
      return TrackOrderCubit(mockWatchOrderUseCase, mockGetDriverUseCase);
    }

    blocTest<TrackOrderCubit, TrackOrderState>(
      'status "wait_for_driver" → step 0 is active',
      build: () => _buildCubit('wait_for_driver'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 2,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isActive, 'step0 active', true),
      ],
    );

    // blocTest<TrackOrderCubit, TrackOrderState>(
    //   'status "pending" → step 1 is active',
    //   build: () => _buildCubit('pending'),
    //   act: (c) => c.doIntent(LoadOrderIntent('id')),
    //   skip: 2,
    //   expect: () => [
    //     isA<TrackOrderState>()
    //         .having((s) => s.isLoading, 'loading', false)
    //         .having((s) => s.steps[0].isDone, 'step0 done', true)
    //         .having((s) => s.steps[1].isActive, 'step1 active', true),
    //   ],
    // );

    // blocTest<TrackOrderCubit, TrackOrderState>(
    //   'status "picked" → step 2 is active',
    //   build: () => _buildCubit('picked'),
    //   act: (c) => c.doIntent(LoadOrderIntent('id')),
    //   skip: 2,
    //   expect: () => [
    //     isA<TrackOrderState>()
    //         .having((s) => s.isLoading, 'loading', false)
    //         .having((s) => s.steps[1].isDone, 'step1 done', true)
    //         .having((s) => s.steps[2].isActive, 'step2 active', true),
    //   ],
    // );

    // blocTest<TrackOrderCubit, TrackOrderState>(
    //   'status "out_for_delivery" → step 3 is active',
    //   build: () => _buildCubit('out_for_delivery'),
    //   act: (c) => c.doIntent(LoadOrderIntent('id')),
    //   skip: 2,
    //   expect: () => [
    //     isA<TrackOrderState>()
    //         .having((s) => s.isLoading, 'loading', false)
    //         .having((s) => s.steps[2].isDone, 'step2 done', true)
    //         .having((s) => s.steps[3].isActive, 'step3 active', true),
    //   ],
    // );

    // blocTest<TrackOrderCubit, TrackOrderState>(
    //   'status "arrived" → step 4 is active',
    //   build: () => _buildCubit('arrived'),
    //   act: (c) => c.doIntent(LoadOrderIntent('id')),
    //   skip: 2,
    //   expect: () => [
    //     isA<TrackOrderState>()
    //         .having((s) => s.isLoading, 'loading', false)
    //         .having((s) => s.steps[3].isDone, 'step3 done', true)
    //         .having((s) => s.steps[4].isActive, 'step4 active', true),
    //   ],
    // );

    // blocTest<TrackOrderCubit, TrackOrderState>(
    //   'status "delivered" → step 5 is active',
    //   build: () => _buildCubit('delivered'),
    //   act: (c) => c.doIntent(LoadOrderIntent('id')),
    //   skip: 2,
    //   expect: () => [
    //     isA<TrackOrderState>()
    //         .having((s) => s.isLoading, 'loading', false)
    //         .having((s) => s.steps[4].isDone, 'step4 done', true)
    //         .having((s) => s.steps[5].isActive, 'step5 active', true),
    //   ],
    // );

    blocTest<TrackOrderCubit, TrackOrderState>(
      'unknown status fallback → step 0 active',
      build: () => _buildCubit('unknown_status'),
      act: (c) => c.doIntent(LoadOrderIntent('id')),
      skip: 2,
      expect: () => [
        isA<TrackOrderState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.steps[0].isActive, 'step0 active', true),
      ],
    );
  });
}
