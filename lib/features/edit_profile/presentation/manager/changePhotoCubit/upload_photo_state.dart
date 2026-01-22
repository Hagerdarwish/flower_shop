import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';

class UploadPhotoState {
  final Resource<EditProfileResponse> uploadPhotoResource;
  final XFile? selectedPhoto;

  UploadPhotoState({
    Resource<EditProfileResponse>? uploadPhotoResource,
    this.selectedPhoto,
  }) : uploadPhotoResource = uploadPhotoResource ?? Resource.initial();

  UploadPhotoState copyWith({
    Resource<EditProfileResponse>? uploadPhotoResource,
    XFile? selectedPhoto,
  }) {
    return UploadPhotoState(
      uploadPhotoResource: uploadPhotoResource ?? this.uploadPhotoResource,
      selectedPhoto: selectedPhoto ?? this.selectedPhoto,
    );
  }
}
