import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../models/reset_password_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<ApiResult<ResetPasswordEntity>> call(
      String email,
      String newPassword,
      ) {
    return _authRepo.resetPassword(email, newPassword);
  }
}
