import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../models/forget_password_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo repo;
  ForgotPasswordUseCase(this.repo);
  Future<ApiResult<ForgotPasswordEntity>> call(String email) {
    return repo.forgotPassword(email);
  }
}
