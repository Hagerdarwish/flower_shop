import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../../../../app/core/network/safe_api_call.dart';
import '../../data/datascource_contract/notification_remote_data_source_contract.dart';
import '../../data/models/delete_all_notifications_response_dto.dart';
import '../../data/models/delete_notification_by_id_response_dto.dart';
import '../../data/models/get_all_notification_response_dto.dart';

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;

  NotificationRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<GetAllNotificationResponseDto>> getNotifications({
    int? page,
    int? limit,
    String? type,
    String? sort,
  }) {
    return safeApiCall<GetAllNotificationResponseDto>(
      call: () => apiClient.getNotifications(
        page: page,
        limit: limit,
        type: type,
        sort: sort,
      ),
    );
  }

  @override
  Future<ApiResult<DeleteAllNotificationsResponseDto>> clearAllNotifications() {
    return safeApiCall<DeleteAllNotificationsResponseDto>(
      call: () => apiClient.clearAllNotifications(),
    );
  }

  @override
  Future<ApiResult<DeleteNotificationByIdResponseDto>> deleteNotificationById(
    String id,
  ) {
    return safeApiCall<DeleteNotificationByIdResponseDto>(
      call: () => apiClient.deleteNotification(id),
    );
  }
}
