import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../repo/notification_repo_contract.dart';

@lazySingleton
class ClearAllNotificationsUseCase {
  final NotificationRepoContract repo;

  ClearAllNotificationsUseCase(this.repo);

  Future<ApiResult<String>> call() {
    return repo.clearAllNotifications();
  }
}
