import 'package:dio/dio.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';

abstract class EditProfileDataSource {
  Future<EditProfileResponse> editProfile({
    required String token,
    EditProfileRequest? request,
  });

  Future<EditProfileResponse> uploadPhoto({
    required String token,
    required MultipartFile photo,
  });
}
