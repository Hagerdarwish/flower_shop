import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUsecase {
  final AuthRepo _authRepo;
  LogoutUsecase(this._authRepo);
  Future<ApiResult<LogoutResponse>> call({required String token}) async {
    return await _authRepo.logout(token: token);
  }
}
