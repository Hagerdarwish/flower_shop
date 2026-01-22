import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/datasources/edit_profile_datasource.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditprofileRepo)
class EditprofileRepoImpl implements EditprofileRepo {
  final EditProfileDataSource editProfileDataSource;

  EditprofileRepoImpl(this.editProfileDataSource);

  @override
  Future<ApiResult<EditProfileResponse>> editProfile({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    final request = EditProfileRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    try {
      final response = await editProfileDataSource.editProfile(
        token: token,
        request: request,
      );

      return SuccessApiResult(data: response);
    } catch (e) {
      return ErrorApiResult(error: tr('error_message'));
    }
  }

  @override
  Future<ApiResult<EditProfileResponse>> uploadPhoto({
    required String token,
    required XFile photo,
  }) async {
    try {
      final bytes = await photo.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: photo.name,
      );

      final response = await editProfileDataSource.uploadPhoto(
        token: token,
        photo: multipartFile,
      );

      return SuccessApiResult(data: response);
    } catch (e) {
      return ErrorApiResult(error: tr('error_message'));
    }
  }
}
