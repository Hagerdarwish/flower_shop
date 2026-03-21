import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendDeviceNotificationUsecase {
  final CheckoutRepo _repo;

  SendDeviceNotificationUsecase(this._repo);

  Future<ApiResult<void>> call(SendDeviceNotificationParams params) =>
      _repo.sendDeviceNotification(
        userId: params.userId,
        title: params.title,
        body: params.body,
      );
}

class SendDeviceNotificationParams {
  final String userId;
  final String title;
  final String body;

  SendDeviceNotificationParams({
    required this.userId,
    required this.title,
    required this.body,
  });
}
