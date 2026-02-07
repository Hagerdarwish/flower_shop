import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../../data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../models/reset_password_entity.dart';
import '../repos/auth_repo.dart';

@lazySingleton
class ChangePasswordUseCase {
  final AuthRepo repo;

  ChangePasswordUseCase(this.repo);

  Future<ApiResult<ResetPasswordEntity>> call(ResetPasswordRequest request) {
    return repo.resetPassword(request);
  }
}
