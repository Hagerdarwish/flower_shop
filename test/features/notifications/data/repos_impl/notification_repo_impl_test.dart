import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/api/datascource_impl/notification_remote_data_source_impl.dart';
import 'package:flower_shop/features/notifications/data/models/delete_all_notifications_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/delete_notification_by_id_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/get_all_notification_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/notification_dto.dart';
import 'package:flower_shop/features/notifications/data/repos_impl/notification_repo_impl.dart';
import 'package:flower_shop/features/notifications/domain/entity/notification_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notification_repo_impl_test.mocks.dart';

@GenerateMocks([NotificationRemoteDataSourceImpl])
void main() {
  late MockNotificationRemoteDataSourceImpl datasource;
  late NotificationRepoImpl repo;

  setUpAll(() {
    provideDummy<ApiResult<GetAllNotificationResponseDto>>(
      SuccessApiResult<GetAllNotificationResponseDto>(
        data: GetAllNotificationResponseDto(notifications: [], message: ''),
      ),
    );
    provideDummy<ApiResult<DeleteAllNotificationsResponseDto>>(
      SuccessApiResult<DeleteAllNotificationsResponseDto>(
        data: DeleteAllNotificationsResponseDto(message: ''),
      ),
    );
    provideDummy<ApiResult<DeleteNotificationByIdResponseDto>>(
      SuccessApiResult<DeleteNotificationByIdResponseDto>(
        data: DeleteNotificationByIdResponseDto(message: ''),
      ),
    );
  });

  setUp(() {
    datasource = MockNotificationRemoteDataSourceImpl();
    repo = NotificationRepoImpl(datasource);
  });

  group("getNotifications", () {
    final fakeNotificationDto = GetAllNotificationResponseDto(
      message: 'Success',
      notifications: [NotificationDto(id: '1', title: 'Hello', body: 'World')],
    );

    test('should return SuccessApiResult when datasource succeeds', () async {
      when(
        datasource.getNotifications(
          page: anyNamed('page'),
          limit: anyNamed('limit'),
          type: anyNamed('type'),
          sort: anyNamed('sort'),
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult<GetAllNotificationResponseDto>(
          data: fakeNotificationDto,
        ),
      );

      final result = await repo.getNotifications();

      expect(result, isA<SuccessApiResult<List<NotificationEntity>>>());
      final data = (result as SuccessApiResult<List<NotificationEntity>>).data;
      expect(data.length, 1);
      expect(data.first.id, '1');

      verify(
        datasource.getNotifications(
          page: null,
          limit: null,
          type: null,
          sort: null,
        ),
      ).called(1);
    });

    test('should return ErrorApiResult when datasource fails', () async {
      when(
        datasource.getNotifications(
          page: anyNamed('page'),
          limit: anyNamed('limit'),
          type: anyNamed('type'),
          sort: anyNamed('sort'),
        ),
      ).thenAnswer(
        (_) async => ErrorApiResult<GetAllNotificationResponseDto>(
          error: 'Network error',
        ),
      );

      final result = await repo.getNotifications();

      expect(result, isA<ErrorApiResult<List<NotificationEntity>>>());
      expect((result as ErrorApiResult).error, 'Network error');

      verify(
        datasource.getNotifications(
          page: null,
          limit: null,
          type: null,
          sort: null,
        ),
      ).called(1);
    });
  });

  group("clearAllNotifications", () {
    final fakeDto = DeleteAllNotificationsResponseDto(message: 'All deleted');

    test('should return SuccessApiResult when datasource succeeds', () async {
      when(datasource.clearAllNotifications()).thenAnswer(
        (_) async =>
            SuccessApiResult<DeleteAllNotificationsResponseDto>(data: fakeDto),
      );

      final result = await repo.clearAllNotifications();

      expect(result, isA<SuccessApiResult<String>>());
      expect((result as SuccessApiResult<String>).data, 'All deleted');
      verify(datasource.clearAllNotifications()).called(1);
    });

    test('should return ErrorApiResult when datasource fails', () async {
      when(datasource.clearAllNotifications()).thenAnswer(
        (_) async => ErrorApiResult<DeleteAllNotificationsResponseDto>(
          error: 'Network error',
        ),
      );

      final result = await repo.clearAllNotifications();

      expect(result, isA<ErrorApiResult<String>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(datasource.clearAllNotifications()).called(1);
    });
  });

  group("deleteNotificationById", () {
    const id = '123';
    final fakeDto = DeleteNotificationByIdResponseDto(message: 'Deleted');

    test('should return SuccessApiResult when datasource succeeds', () async {
      when(datasource.deleteNotificationById(id)).thenAnswer(
        (_) async =>
            SuccessApiResult<DeleteNotificationByIdResponseDto>(data: fakeDto),
      );

      final result = await repo.deleteNotificationById(id);

      expect(result, isA<SuccessApiResult<String>>());
      expect((result as SuccessApiResult<String>).data, 'Deleted');
      verify(datasource.deleteNotificationById(id)).called(1);
    });

    test('should return ErrorApiResult when datasource fails', () async {
      when(datasource.deleteNotificationById(id)).thenAnswer(
        (_) async => ErrorApiResult<DeleteNotificationByIdResponseDto>(
          error: 'Network error',
        ),
      );

      final result = await repo.deleteNotificationById(id);

      expect(result, isA<ErrorApiResult<String>>());
      expect((result as ErrorApiResult).error, 'Network error');
      verify(datasource.deleteNotificationById(id)).called(1);
    });
  });
}
