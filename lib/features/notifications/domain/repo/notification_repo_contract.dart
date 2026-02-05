import 'package:flower_shop/app/core/network/api_result.dart';
import '../entity/notification_entity.dart';

abstract class NotificationRepoContract {
  Future<ApiResult<List<NotificationEntity>>> getNotifications({
    int? page,
    int? limit,
    String? type,
    String? sort,
  });

  Future<ApiResult<String>> clearAllNotifications();

  Future<ApiResult<String>> deleteNotificationById(String id);
}
