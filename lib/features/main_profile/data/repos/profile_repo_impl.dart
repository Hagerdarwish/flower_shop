import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/profile_remote_data_source.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileremoteDataSource profileRemoteDataSource;
  final SharedPreferences prefs;

  ProfileRepoImpl({required this.profileRemoteDataSource, required this.prefs});

  @override
  Future<ApiResult<ProfileUserModel>> getCurrentUser() async {
    final result = await profileRemoteDataSource.getProfile();

    if (result is SuccessApiResult<ProfileResponse>) {
      final ProfileUserModel user = result.data.toDomain();
      return SuccessApiResult(data: user);
    } else if (result is ErrorApiResult<ProfileResponse>) {
      return ErrorApiResult(error: result.error);
    } else {
      return ErrorApiResult(error: 'Unknown error');
    }
  }
}
