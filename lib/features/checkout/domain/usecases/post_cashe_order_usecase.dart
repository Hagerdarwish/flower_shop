// lib/features/main_profile/domain/usecase/get_current_user_usecase.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostCasheOrderUsecase {
  final CheckoutRepo repo;

  PostCasheOrderUsecase(this.repo);

  Future<ApiResult<CashOrderModel>> call(String token) async {
    return await repo.postCashOrder(token);
  }
}
