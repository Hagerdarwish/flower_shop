import 'package:flower_shop/app/features/auth/data/models/request/reset_password_request_model/reset_password_request_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_result.dart';
import '../models/reset_password_entity.dart';
import '../repos/auth_repo.dart';

@lazySingleton

class ResetPasswordUseCase {
  final AuthRepo repo;

  ResetPasswordUseCase(this.repo);

  Future<ApiResult<ResetPasswordEntity>> call(ResetPasswordRequest request) {
    return repo.resetPassword(request);
  }
}