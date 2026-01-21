import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRepo {
  Future<ApiResult<ProfileUserModel>> getCurrentUser(String token);
}
