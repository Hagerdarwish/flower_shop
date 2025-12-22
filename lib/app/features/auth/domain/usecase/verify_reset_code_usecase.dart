import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../models/reset_code_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo repo;

  VerifyResetCodeUseCase(this.repo);

  Future<ApiResult<ResetCodeEntity>> call(String code) {
    return repo.verifyResetCode(code);
  }
}
