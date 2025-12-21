import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginModel>> login(String email, String password);
}