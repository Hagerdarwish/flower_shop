import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/changepass_response/changePassRespnse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/changePass_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangepassUsecase {
  ChangepassRepo changepassRepo;
  ChangepassUsecase(this.changepassRepo);

  Future<ApiResult<ChangePassResponse>> call({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    return await changepassRepo.changePass(
      token: token,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
