import 'package:flower_shop/features/notifications/domain/usecase/get_all_notifications_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/domain/repo/notification_repo_contract.dart';
import 'package:flower_shop/features/notifications/domain/entity/notification_entity.dart';

import 'get_all_notifications_usecase_test.mocks.dart';

@GenerateMocks([NotificationRepoContract])
void main() {
  late MockNotificationRepoContract mockRepo;
  late GetNotificationsUseCase usecase;

  setUpAll(() {
    mockRepo = MockNotificationRepoContract();
    usecase = GetNotificationsUseCase(mockRepo);

    provideDummy<ApiResult<List<NotificationEntity>>>(
      SuccessApiResult<List<NotificationEntity>>(data: []),
    );
  });

  group('GetNotificationsUseCase', () {
    final fakeNotifications = [
      NotificationEntity(id: '1', title: 'Hello', body: 'World'),
    ];

    test('returns SuccessApiResult when repo succeeds', () async {
      when(mockRepo.getNotifications()).thenAnswer(
        (_) async =>
            SuccessApiResult<List<NotificationEntity>>(data: fakeNotifications),
      );

      final result = await usecase.call();

      expect(result, isA<SuccessApiResult<List<NotificationEntity>>>());
      final data = (result as SuccessApiResult<List<NotificationEntity>>).data;
      expect(data.length, 1);
      expect(data.first.id, '1');
      verify(mockRepo.getNotifications()).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      when(mockRepo.getNotifications()).thenAnswer(
        (_) async =>
            ErrorApiResult<List<NotificationEntity>>(error: 'Network error'),
      );

      final result = await usecase.call();

      expect(result, isA<ErrorApiResult<List<NotificationEntity>>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(mockRepo.getNotifications()).called(1);
    });
  });
}
