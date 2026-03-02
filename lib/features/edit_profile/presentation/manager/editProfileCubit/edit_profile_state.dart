import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';

class EditProfileStates {
  final Resource<EditProfileResponse> editProfileResource;

  EditProfileStates({Resource<EditProfileResponse>? editProfileResource})
    : editProfileResource = editProfileResource ?? Resource.initial();

  EditProfileStates copyWith({
    Resource<EditProfileResponse>? editProfileResource,
  }) {
    return EditProfileStates(
      editProfileResource: editProfileResource ?? this.editProfileResource,
    );
  }
}
