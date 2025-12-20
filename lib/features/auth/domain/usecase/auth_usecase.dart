import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthUsecase {
  AuthRepo authRepo;
  AuthUsecase(this.authRepo);
  Future<ApiResult<SignupModel>> call({
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? gender,
  }) => authRepo.signup(
    fName: fName,
    lName: lName,
    email: email,
    password: password,
    confirmPassword: confirmPassword,
    phoneNumber: phone,
    gender: gender,
  );
}
