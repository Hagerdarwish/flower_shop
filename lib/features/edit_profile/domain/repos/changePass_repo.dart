import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/changepass_response/changePassRespnse.dart';

abstract class ChangepassRepo {
  Future<ApiResult<ChangePassResponse>> changePass({
    required String token,
    required String oldPassword,
    required String newPassword,
  });
}
