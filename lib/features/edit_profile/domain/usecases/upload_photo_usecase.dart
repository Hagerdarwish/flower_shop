import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditprofileRepo editProfileRepo;

  UploadPhotoUseCase(this.editProfileRepo);

  Future<ApiResult<EditProfileResponse>> call({
    required String token,
    required XFile photo,
  }) {
    return editProfileRepo.uploadPhoto(token: token, photo: photo);
  }
}
