// lib/features/main_profile/domain/usecase/get_current_user_usecase.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUsecase {
  final ProfileRepo repo;

  GetCurrentUserUsecase(this.repo);

  Future<ApiResult<ProfileUserModel>> call(String token) async {
    return await repo.getCurrentUser(token);
  }
}
