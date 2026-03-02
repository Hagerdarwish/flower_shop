import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/domain/usecase/clear_all_notifications_usecase.dart';
import 'package:flower_shop/features/notifications/domain/repo/notification_repo_contract.dart';

import 'clear_all_notifications_usecase_test.mocks.dart';

@GenerateMocks([NotificationRepoContract])
void main() {
  late MockNotificationRepoContract mockRepo;
  late ClearAllNotificationsUseCase usecase;

  setUpAll(() {
    mockRepo = MockNotificationRepoContract();
    usecase = ClearAllNotificationsUseCase(mockRepo);

    provideDummy<ApiResult<String>>(SuccessApiResult<String>(data: ''));
  });

  group('ClearAllNotificationsUseCase', () {
    test('returns SuccessApiResult when repo succeeds', () async {
      when(
        mockRepo.clearAllNotifications(),
      ).thenAnswer((_) async => SuccessApiResult<String>(data: 'All deleted'));

      final result = await usecase.call();

      expect(result, isA<SuccessApiResult<String>>());
      expect((result as SuccessApiResult<String>).data, 'All deleted');
      verify(mockRepo.clearAllNotifications()).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      when(
        mockRepo.clearAllNotifications(),
      ).thenAnswer((_) async => ErrorApiResult<String>(error: 'Network error'));

      final result = await usecase.call();

      expect(result, isA<ErrorApiResult<String>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(mockRepo.clearAllNotifications()).called(1);
    });
  });
}
