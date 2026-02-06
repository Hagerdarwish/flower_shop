import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/domain/entity/notification_entity.dart';
import 'package:flower_shop/features/notifications/domain/usecase/clear_all_notifications_usecase.dart';
import 'package:flower_shop/features/notifications/domain/usecase/delete_notification_by_id_usecase.dart';
import 'package:flower_shop/features/notifications/domain/usecase/get_all_notifications_usecase.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_intent.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_state.dart';

import 'notifications_cubit_test.mocks.dart';

@GenerateMocks([
  GetNotificationsUseCase,
  ClearAllNotificationsUseCase,
  DeleteNotificationUseCase,
])
void main() {
  late MockGetNotificationsUseCase mockGetUseCase;
  late MockClearAllNotificationsUseCase mockClearUseCase;
  late MockDeleteNotificationUseCase mockDeleteUseCase;
  late NotificationsCubit cubit;

  final fakeNotifications = [
    NotificationEntity(id: '1', title: 'Title1', body: 'Body1'),
    NotificationEntity(id: '2', title: 'Title2', body: 'Body2'),
  ];

  setUp(() {
    mockGetUseCase = MockGetNotificationsUseCase();
    mockClearUseCase = MockClearAllNotificationsUseCase();
    mockDeleteUseCase = MockDeleteNotificationUseCase();

    cubit = NotificationsCubit(
      mockGetUseCase,
      mockClearUseCase,
      mockDeleteUseCase,
    );

    // Dummy API results for provideDummy
    provideDummy<ApiResult<List<NotificationEntity>>>(
      SuccessApiResult<List<NotificationEntity>>(data: []),
    );
    provideDummy<ApiResult<String>>(SuccessApiResult<String>(data: ''));
  });

  tearDown(() async {
    await cubit.close();
  });

  group('Load Notifications', () {
    blocTest<NotificationsCubit, NotificationsState>(
      'emits loading then success when getNotifications succeeds',
      build: () {
        when(
          mockGetUseCase.call(page: 1, limit: 40),
        ).thenAnswer((_) async => SuccessApiResult(data: fakeNotifications));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const LoadNotificationsIntent()),
      expect: () => [
        isA<NotificationsState>().having(
          (s) => s.resource.isLoading,
          'loading',
          true,
        ),
        isA<NotificationsState>()
            .having((s) => s.resource.isSuccess, 'success', true)
            .having((s) => s.resource.data?.length, 'data length', 2),
      ],
      verify: (_) {
        verify(mockGetUseCase.call(page: 1, limit: 40)).called(1);
      },
    );

    blocTest<NotificationsCubit, NotificationsState>(
      'emits loading then error when getNotifications fails',
      build: () {
        when(
          mockGetUseCase.call(page: 1, limit: 40),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Network error'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const LoadNotificationsIntent()),
      expect: () => [
        isA<NotificationsState>().having(
          (s) => s.resource.isLoading,
          'loading',
          true,
        ),
        isA<NotificationsState>()
            .having((s) => s.resource.isError, 'error', true)
            .having((s) => s.resource.error, 'error message', 'Network error'),
      ],
      verify: (_) {
        verify(mockGetUseCase.call(page: 1, limit: 40)).called(1);
      },
    );
  });

  group('Clear All Notifications', () {
    blocTest<NotificationsCubit, NotificationsState>(
      'emits loading then cleared when clearAll succeeds',
      build: () {
        when(
          mockClearUseCase.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: 'Deleted'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const ClearAllNotificationsIntent()),
      expect: () => [
        isA<NotificationsState>().having(
          (s) => s.resource.isLoading,
          'loading',
          true,
        ),
        isA<NotificationsState>()
            .having((s) => s.lastAction, 'cleared', NotificationsAction.cleared)
            .having((s) => s.resource.data?.length, 'empty list', 0),
      ],
      verify: (_) {
        verify(mockClearUseCase.call()).called(1);
      },
    );

    blocTest<NotificationsCubit, NotificationsState>(
      'emits loading then error when clearAll fails',
      build: () {
        when(
          mockClearUseCase.call(),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const ClearAllNotificationsIntent()),
      expect: () => [
        isA<NotificationsState>().having(
          (s) => s.resource.isLoading,
          'loading',
          true,
        ),
        isA<NotificationsState>()
            .having(
              (s) => s.lastAction,
              'action none',
              NotificationsAction.none,
            )
            .having((s) => s.resource.isError, 'error', true)
            .having((s) => s.resource.error, 'error message', 'Failed'),
      ],
      verify: (_) {
        verify(mockClearUseCase.call()).called(1);
      },
    );
  });

  group('Delete Notification', () {
    const idToDelete = '1';

    blocTest<NotificationsCubit, NotificationsState>(
      'removes item and emits deleted when delete succeeds',
      build: () {
        when(
          mockDeleteUseCase.call(idToDelete),
        ).thenAnswer((_) async => SuccessApiResult(data: 'Deleted'));
        cubit.emit(
          cubit.state.copyWith(resource: Resource.success(fakeNotifications)),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(DeleteNotificationIntent(idToDelete)),
      expect: () => [
        isA<NotificationsState>().having(
          (s) => s.resource.data?.length,
          'item removed',
          1,
        ),
        isA<NotificationsState>().having(
          (s) => s.lastAction,
          'deleted',
          NotificationsAction.deleted,
        ),
      ],
      verify: (_) {
        verify(mockDeleteUseCase.call(idToDelete)).called(1);
      },
    );

    blocTest<NotificationsCubit, NotificationsState>(
      'rolls back and emits error when delete fails',
      build: () {
        when(
          mockDeleteUseCase.call(idToDelete),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));
        cubit.emit(
          cubit.state.copyWith(resource: Resource.success(fakeNotifications)),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(DeleteNotificationIntent(idToDelete)),
      expect: () => [
        // first emit: remove locally
        isA<NotificationsState>().having(
          (s) => s.resource.data?.length,
          'item removed',
          1,
        ),
        // second emit: rollback
        isA<NotificationsState>().having(
          (s) => s.resource.data?.length,
          'rollback',
          2,
        ),
        // third emit: error state
        isA<NotificationsState>()
            .having((s) => s.resource.isError, 'error', true)
            .having((s) => s.resource.error, 'error message', 'Failed'),
      ],
      verify: (_) {
        verify(mockDeleteUseCase.call(idToDelete)).called(1);
      },
    );
  });
}
