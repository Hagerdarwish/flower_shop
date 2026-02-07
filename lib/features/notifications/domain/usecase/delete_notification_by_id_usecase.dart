import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:injectable/injectable.dart';
import '../repo/notification_repo_contract.dart';

@lazySingleton
class DeleteNotificationUseCase {
  final NotificationRepoContract repo;

  DeleteNotificationUseCase(this.repo);

  Future<ApiResult<String>> call(String id) {
    return repo.deleteNotificationById(id);
  }
}
