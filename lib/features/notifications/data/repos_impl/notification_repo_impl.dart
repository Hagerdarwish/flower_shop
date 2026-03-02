import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repo/notification_repo_contract.dart';
import '../datascource_contract/notification_remote_data_source_contract.dart';
import '../models/delete_all_notifications_response_dto.dart';
import '../models/delete_notification_by_id_response_dto.dart';
import '../models/get_all_notification_response_dto.dart';

@Injectable(as: NotificationRepoContract)
class NotificationRepoImpl implements NotificationRepoContract {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepoImpl(this.remoteDataSource);

  @override
  Future<ApiResult<List<NotificationEntity>>> getNotifications({
    int? page,
    int? limit,
    String? type,
    String? sort,
  }) async {
    final result = await remoteDataSource.getNotifications(
      page: page,
      limit: limit,
      type: type,
      sort: sort,
    );

    if (result is SuccessApiResult<GetAllNotificationResponseDto>) {
      final dto = result.data;

      final notifications =
          dto.notifications?.map((e) => e.toEntity()).toList() ?? [];

      return SuccessApiResult<List<NotificationEntity>>(data: notifications);
    }

    if (result is ErrorApiResult<GetAllNotificationResponseDto>) {
      return ErrorApiResult<List<NotificationEntity>>(error: result.error);
    }

    return ErrorApiResult<List<NotificationEntity>>(error: 'Unexpected error');
  }

  @override
  Future<ApiResult<String>> clearAllNotifications() async {
    final result = await remoteDataSource.clearAllNotifications();

    if (result is SuccessApiResult<DeleteAllNotificationsResponseDto>) {
      return SuccessApiResult<String>(
        data: result.data.message ?? 'Deleted successfully',
      );
    }

    if (result is ErrorApiResult<DeleteAllNotificationsResponseDto>) {
      return ErrorApiResult<String>(error: result.error);
    }

    return ErrorApiResult<String>(error: 'Unexpected error');
  }

  @override
  Future<ApiResult<String>> deleteNotificationById(String id) async {
    final result = await remoteDataSource.deleteNotificationById(id);

    if (result is SuccessApiResult<DeleteNotificationByIdResponseDto>) {
      return SuccessApiResult<String>(
        data: result.data.message ?? 'Deleted successfully',
      );
    }

    if (result is ErrorApiResult<DeleteNotificationByIdResponseDto>) {
      return ErrorApiResult<String>(error: result.error);
    }

    return ErrorApiResult<String>(error: 'Unexpected error');
  }
}
