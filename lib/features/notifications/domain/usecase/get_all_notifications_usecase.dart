import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entity/notification_entity.dart';
import '../repo/notification_repo_contract.dart';

@lazySingleton
class GetNotificationsUseCase {
  final NotificationRepoContract repo;

  GetNotificationsUseCase(this.repo);

  Future<ApiResult<List<NotificationEntity>>> call({
    int? page,
    int? limit,
    String? type,
    String? sort,
  }) {
    return repo.getNotifications(
      page: page,
      limit: limit,
      type: type,
      sort: sort,
    );
  }
}
