import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';

abstract class EditprofileRepo {
  Future<ApiResult<EditProfileResponse>> editProfile({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  });

  Future<ApiResult<EditProfileResponse>> uploadPhoto({
    required String token,
    required XFile photo,
  });
}
