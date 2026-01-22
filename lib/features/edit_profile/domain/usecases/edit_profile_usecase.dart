import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditprofileRepo editProfileRepo;

  EditProfileUseCase(this.editProfileRepo);

  Future<ApiResult<EditProfileResponse>> call({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    return editProfileRepo.editProfile(
      token: token,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
