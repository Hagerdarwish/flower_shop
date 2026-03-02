import 'package:injectable/injectable.dart';

import '../../../../app/core/network/api_result.dart';
import '../../data/models/request/change-password-request-models/change-password-request-model.dart';
import '../models/change_password_entity.dart';
import '../repos/auth_repo.dart';

@lazySingleton
class ChangePasswordUseCase {
  final AuthRepo repo;

  ChangePasswordUseCase(this.repo);

  Future<ApiResult<ChangePasswordEntity>> call(ChangePasswordRequest request) {
    return repo.changePassword(request);
  }
}
