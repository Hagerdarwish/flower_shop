import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/notifications/api/datascource_impl/notification_remote_data_source_impl.dart';
import 'package:flower_shop/features/notifications/data/models/delete_all_notifications_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/delete_notification_by_id_response_dto.dart';
import 'package:flower_shop/features/notifications/data/models/get_all_notification_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late NotificationRemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    mockApiClient = MockApiClient();
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = NotificationRemoteDataSourceImpl(
      mockApiClient,
      firestore: fakeFirestore,
    );
  });

  group("NotificationRemoteDataSourceImpl", () {
    test(
      'getNotifications should return notifications from Firestore mapped correctly',
      () async {
        // Arrange
        await fakeFirestore.collection('notification').add({
          'title': 'Test Title',
          'des': 'Test Body',
          'createdAt': '2026-03-03T10:00:00.000Z',
        });

        // Act
        final result = await dataSource.getNotifications();

        // Assert
        expect(result, isA<SuccessApiResult<GetAllNotificationResponseDto>>());

        final successResult =
            result as SuccessApiResult<GetAllNotificationResponseDto>;

        expect(successResult.data.notifications, isNotNull);
        expect(successResult.data.notifications!.length, 1);

        final notification = successResult.data.notifications!.first;

        expect(notification.title, 'Test Title');
        expect(notification.body, 'Test Body');
        expect(notification.createdAt, '2026-03-03T10:00:00.000Z');
      },
    );

    test(
      'clearAllNotifications should delete all documents in collection',
      () async {
        // Arrange
        await fakeFirestore.collection('notification').add({'title': 'Test 1'});
        await fakeFirestore.collection('notification').add({'title': 'Test 2'});

        // Act
        final result = await dataSource.clearAllNotifications();

        // Assert
        expect(
          result,
          isA<SuccessApiResult<DeleteAllNotificationsResponseDto>>(),
        );
        final snapshot = await fakeFirestore.collection('notification').get();
        expect(snapshot.docs.isEmpty, true);
      },
    );

    test('deleteNotificationById should delete a specific document', () async {
      // Arrange
      final docRef = await fakeFirestore.collection('notification').add({
        'title': 'Test 1',
      });
      await fakeFirestore.collection('notification').add({'title': 'Test 2'});

      // Act
      final result = await dataSource.deleteNotificationById(docRef.id);

      // Assert
      expect(
        result,
        isA<SuccessApiResult<DeleteNotificationByIdResponseDto>>(),
      );
      final snapshot = await fakeFirestore.collection('notification').get();
      expect(snapshot.docs.length, 1);
      expect(snapshot.docs.first.data()['title'], 'Test 2');
    });
  });
}
