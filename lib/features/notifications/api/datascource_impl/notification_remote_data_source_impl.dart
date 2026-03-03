import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../../data/datascource_contract/notification_remote_data_source_contract.dart';
import '../../data/models/delete_all_notifications_response_dto.dart';
import '../../data/models/delete_notification_by_id_response_dto.dart';
import '../../data/models/get_all_notification_response_dto.dart';
import '../../data/models/notification_dto.dart';
import '../../data/models/metadata_dto.dart';

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;
  final FirebaseFirestore firestore;

  NotificationRemoteDataSourceImpl(
    this.apiClient, {
    FirebaseFirestore? firestore,
  }) : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ApiResult<GetAllNotificationResponseDto>> getNotifications({
    int? page,
    int? limit,
    String? type,
    String? sort,
  }) async {
    try {
      final querySnapshot = await firestore
          .collection('notification')
          .orderBy('createdAt', descending: true)
          .get();

      final notifications = querySnapshot.docs.map((doc) {
        final data = doc.data();

        String? createdAtStr;
        if (data['createdAt'] is Timestamp) {
          createdAtStr = (data['createdAt'] as Timestamp)
              .toDate()
              .toIso8601String();
        } else if (data['createdAt'] is String) {
          createdAtStr = data['createdAt'] as String;
        }

        return NotificationDto(
          id: doc.id,
          title: data['title'] as String?,
          body: data['description'] as String?,
          createdAt: createdAtStr,
        );
      }).toList();

      return SuccessApiResult<GetAllNotificationResponseDto>(
        data: GetAllNotificationResponseDto(
          message: "Success",
          metadata: MetadataDto(),
          notifications: notifications,
        ),
      );
    } catch (e) {
      return ErrorApiResult<GetAllNotificationResponseDto>(error: e.toString());
    }
  }

  @override
  Future<ApiResult<DeleteAllNotificationsResponseDto>>
  clearAllNotifications() async {
    try {
      final batch = firestore.batch();
      final collection = firestore.collection('notification');

      final snapshot = await collection.get();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      return SuccessApiResult<DeleteAllNotificationsResponseDto>(
        data: DeleteAllNotificationsResponseDto(
          message: "Deleted successfully",
        ),
      );
    } catch (e) {
      return ErrorApiResult<DeleteAllNotificationsResponseDto>(
        error: e.toString(),
      );
    }
  }

  @override
  Future<ApiResult<DeleteNotificationByIdResponseDto>> deleteNotificationById(
    String id,
  ) async {
    try {
      await firestore.collection('notification').doc(id).delete();

      return SuccessApiResult<DeleteNotificationByIdResponseDto>(
        data: DeleteNotificationByIdResponseDto(
          message: "Deleted successfully",
        ),
      );
    } catch (e) {
      return ErrorApiResult<DeleteNotificationByIdResponseDto>(
        error: e.toString(),
      );
    }
  }
}
