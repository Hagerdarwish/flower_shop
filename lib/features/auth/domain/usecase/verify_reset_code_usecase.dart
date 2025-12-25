import 'package:injectable/injectable.dart';
import '../../../../app/core/network/api_result.dart';
import '../models/verify_reset_code_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo repo;

  VerifyResetCodeUseCase(this.repo);

  Future<ApiResult<VerifyResetCodeEntity>> call(String code) {
    return repo.verifyResetCode(code);
  }
}
