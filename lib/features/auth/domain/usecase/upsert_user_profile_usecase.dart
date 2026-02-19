import 'package:injectable/injectable.dart';
import '../../data/models/request/user_profile_model.dart';
import '../repos/auth_repo.dart';

@injectable
class UpsertUserProfileUseCase {
  final AuthRepo repo;

  UpsertUserProfileUseCase(this.repo);

  Future<void> call(UserProfileModel model) {
    return repo.upsertUserProfile(model);
  }
}
