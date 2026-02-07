import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';

class AuthStates {
  SignupState? signupState;
  AuthStates({this.signupState});
  AuthStates copywith({SignupState? signupStateCopywith}) {
    return AuthStates(signupState: signupStateCopywith ?? signupState);
  }
}

class SignupState extends Resource<SignupModel> {
  final bool? changeFirstName;
  final bool? changeLastName;
  final bool? changeEmail;
  final bool? changePassword;
  final bool? changeConfirmPassword;
  final bool? changePhone;
  final bool? changeGender;
  final String? genderError;

  SignupState({
    super.status = Status.initial,
    super.data,
    super.error,
    this.changeFirstName,
    this.changeLastName,
    this.changeEmail,
    this.changePassword,
    this.changeConfirmPassword,
    this.changePhone,
    this.changeGender,
    this.genderError,
  });
}
