import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/api/datascource_impl/notification_remote_data_source_impl.dart';
import 'package:flower_shop/features/notifications/data/models/delete_all_notifications_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/delete_notification_by_id_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/get_all_notification_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';

import 'notification_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late NotificationRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = NotificationRemoteDataSourceImpl(mockApiClient);
  });

  group("NotificationRemoteDataSourceImpl.getNotifications()", () {
    test('should return SuccessApiResult when API call succeeds', () async {
      final dto = GetAllNotificationResponseDto(
        message: 'Success',
        notifications: [],
      );
      final fakeResponse = HttpResponse(
        dto,
        Response(
          requestOptions: RequestOptions(path: '/notifications'),
          statusCode: 200,
          data: dto,
        ),
      );

      when(
        mockApiClient.getNotifications(
          page: anyNamed('page'),
          limit: anyNamed('limit'),
          type: anyNamed('type'),
          sort: anyNamed('sort'),
        ),
      ).thenAnswer((_) async => fakeResponse);

      final result = await dataSource.getNotifications();

      expect(result, isA<SuccessApiResult<GetAllNotificationResponseDto>>());
      final successResult =
          result as SuccessApiResult<GetAllNotificationResponseDto>;
      expect(successResult.data.message, 'Success');

      verify(
        mockApiClient.getNotifications(
          page: null,
          limit: null,
          type: null,
          sort: null,
        ),
      ).called(1);
    });

    test(
      'should return ErrorApiResult when API call throws exception',
      () async {
        when(
          mockApiClient.getNotifications(
            page: anyNamed('page'),
            limit: anyNamed('limit'),
            type: anyNamed('type'),
            sort: anyNamed('sort'),
          ),
        ).thenThrow(Exception('Network error'));

        final result = await dataSource.getNotifications();

        expect(result, isA<ErrorApiResult<GetAllNotificationResponseDto>>());
        final errorResult =
            result as ErrorApiResult<GetAllNotificationResponseDto>;
        expect(errorResult.error.toString(), contains('Network error'));

        verify(
          mockApiClient.getNotifications(
            page: null,
            limit: null,
            type: null,
            sort: null,
          ),
        ).called(1);
      },
    );
  });

  group("NotificationRemoteDataSourceImpl.clearAllNotifications()", () {
    test('should return SuccessApiResult when API call succeeds', () async {
      final dto = DeleteAllNotificationsResponseDto(message: 'All deleted');
      final fakeResponse = HttpResponse(
        dto,
        Response(
          requestOptions: RequestOptions(path: '/notifications/clear'),
          statusCode: 200,
          data: dto,
        ),
      );

      when(
        mockApiClient.clearAllNotifications(),
      ).thenAnswer((_) async => fakeResponse);

      final result = await dataSource.clearAllNotifications();

      expect(
        result,
        isA<SuccessApiResult<DeleteAllNotificationsResponseDto>>(),
      );
      final successResult =
          result as SuccessApiResult<DeleteAllNotificationsResponseDto>;
      expect(successResult.data.message, 'All deleted');

      verify(mockApiClient.clearAllNotifications()).called(1);
    });

    test(
      'should return ErrorApiResult when API call throws exception',
      () async {
        when(
          mockApiClient.clearAllNotifications(),
        ).thenThrow(Exception('Network error'));

        final result = await dataSource.clearAllNotifications();

        expect(
          result,
          isA<ErrorApiResult<DeleteAllNotificationsResponseDto>>(),
        );
        final errorResult =
            result as ErrorApiResult<DeleteAllNotificationsResponseDto>;
        expect(errorResult.error.toString(), contains('Network error'));

        verify(mockApiClient.clearAllNotifications()).called(1);
      },
    );
  });

  group("NotificationRemoteDataSourceImpl.deleteNotificationById()", () {
    const id = '123';

    test('should return SuccessApiResult when API call succeeds', () async {
      final dto = DeleteNotificationByIdResponseDto(message: 'Deleted');
      final fakeResponse = HttpResponse(
        dto,
        Response(
          requestOptions: RequestOptions(path: '/notifications/$id'),
          statusCode: 200,
          data: dto,
        ),
      );

      when(
        mockApiClient.deleteNotification(id),
      ).thenAnswer((_) async => fakeResponse);

      final result = await dataSource.deleteNotificationById(id);

      expect(
        result,
        isA<SuccessApiResult<DeleteNotificationByIdResponseDto>>(),
      );
      final successResult =
          result as SuccessApiResult<DeleteNotificationByIdResponseDto>;
      expect(successResult.data.message, 'Deleted');

      verify(mockApiClient.deleteNotification(id)).called(1);
    });

    test(
      'should return ErrorApiResult when API call throws exception',
      () async {
        when(
          mockApiClient.deleteNotification(id),
        ).thenThrow(Exception('Network error'));

        final result = await dataSource.deleteNotificationById(id);

        expect(
          result,
          isA<ErrorApiResult<DeleteNotificationByIdResponseDto>>(),
        );
        final errorResult =
            result as ErrorApiResult<DeleteNotificationByIdResponseDto>;
        expect(errorResult.error.toString(), contains('Network error'));

        verify(mockApiClient.deleteNotification(id)).called(1);
      },
    );
  });
}
