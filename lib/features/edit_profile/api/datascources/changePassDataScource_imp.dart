import 'package:flower_shop/features/edit_profile/data/datascources/changePassDataScource.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/changepass_request/changePassrequest.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/changepass_response/changePassRespnse.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/api_manger/api_client.dart';

@Injectable(as: ChangepassDatascource)
class ChangepassDatascourceImp extends ChangepassDatascource {
  final ApiClient apiClient;
  ChangepassDatascourceImp(this.apiClient);
  @override
  Future<ChangePassResponse> changePass({
    required String token,
    required ChangePassRequest request,
  }) async {
    try {
      final response = await apiClient.changePassword(token, request);
      return response.data!;
    } catch (e) {
      print("Error in DataSource: $e");
      rethrow;
    }
  }
}
