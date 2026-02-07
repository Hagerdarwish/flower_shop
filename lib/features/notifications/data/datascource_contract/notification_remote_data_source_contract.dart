import '../../../../app/core/network/api_result.dart';
import '../models/delete_all_notifications_response_dto.dart';
import '../models/delete_notification_by_id_response_dto.dart';
import '../models/get_all_notification_response_dto.dart';

abstract class NotificationRemoteDataSource {
  Future<ApiResult<GetAllNotificationResponseDto>> getNotifications({
    int? page,
    int? limit,
    String? type,
    String? sort,
  });

  Future<ApiResult<DeleteAllNotificationsResponseDto>> clearAllNotifications();

  Future<ApiResult<DeleteNotificationByIdResponseDto>> deleteNotificationById(
    String id,
  );
}
