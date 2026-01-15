import 'package:flower_shop/features/edit_profile/data/datascources/editProfileDataScource.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/api_manger/api_client.dart';

@Injectable(as: EditProfileDataSource)
class EditprofiledatascourceImp extends EditProfileDataSource {
  final ApiClient apiClient;
  EditprofiledatascourceImp(this.apiClient);
  @override
  Future<EditProfileResponse> editProfile({
    required String token,
    EditProfileRequest? request,
  }) async {
    try {
      final response = await apiClient.editProfile(
        token: token,
        request: request!,
      );
      return response.data!;
    } catch (e) {
      print("Error in DataSource: $e");
      rethrow;
    }
  }
}
