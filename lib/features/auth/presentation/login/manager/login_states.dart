import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';

class LoginStates {
  final Resource<LoginModel> loginResource;
  final bool rememberMe;

  LoginStates({
    Resource<LoginModel>? loginResource,
    this.rememberMe = false,
  }) : loginResource = loginResource ?? Resource.initial();

  LoginStates copyWith({
    Resource<LoginModel>? loginResource,
    bool? rememberMe,
    String? validationError,
  }) {
    return LoginStates(
      loginResource: loginResource ?? this.loginResource,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
