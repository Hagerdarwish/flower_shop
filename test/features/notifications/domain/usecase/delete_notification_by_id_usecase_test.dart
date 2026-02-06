import 'package:flower_shop/features/notifications/domain/usecase/delete_notification_by_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/domain/repo/notification_repo_contract.dart';

import 'delete_notification_by_id_usecase_test.mocks.dart';

@GenerateMocks([NotificationRepoContract])
void main() {
  late MockNotificationRepoContract mockRepo;
  late DeleteNotificationUseCase usecase;

  setUpAll(() {
    mockRepo = MockNotificationRepoContract();
    usecase = DeleteNotificationUseCase(mockRepo);

    provideDummy<ApiResult<String>>(SuccessApiResult<String>(data: ''));
  });

  group('DeleteNotificationUseCase', () {
    const id = '123';

    test('returns SuccessApiResult when repo succeeds', () async {
      when(
        mockRepo.deleteNotificationById(id),
      ).thenAnswer((_) async => SuccessApiResult<String>(data: 'Deleted'));

      final result = await usecase.call(id);

      expect(result, isA<SuccessApiResult<String>>());
      expect((result as SuccessApiResult<String>).data, 'Deleted');
      verify(mockRepo.deleteNotificationById(id)).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      when(
        mockRepo.deleteNotificationById(id),
      ).thenAnswer((_) async => ErrorApiResult<String>(error: 'Network error'));

      final result = await usecase.call(id);

      expect(result, isA<ErrorApiResult<String>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(mockRepo.deleteNotificationById(id)).called(1);
    });
  });
}
