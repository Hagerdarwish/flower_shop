import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUsecases {
  final ProfileRepo profileRepo;

  GetOrdersUsecases(this.profileRepo);

  Future<ApiResult<OrderResponse>> call({required String token}) {
    return profileRepo.getOrders(token: token);
  }
}
