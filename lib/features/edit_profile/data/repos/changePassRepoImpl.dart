import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/datascources/changePassDataScource.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/changepass_request/changePassrequest.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/changepass_response/changePassRespnse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/changePass_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangepassRepo)
class Changepassrepoimpl extends ChangepassRepo {
  ChangepassDatascource changepassDatascource;
  Changepassrepoimpl(this.changepassDatascource);
  @override
  Future<ApiResult<ChangePassResponse>> changePass({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    final request = ChangePassRequest(
      password: oldPassword,
      newPassword: newPassword,
    );

    try {
      final response = await changepassDatascource.changePass(
        token: token,
        request: request,
      );
      return SuccessApiResult(data: response);
    } catch (e) {
      return ErrorApiResult(error: e.toString());
    }
  }
}
