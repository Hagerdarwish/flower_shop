import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_intent.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/features/auth/domain/usecase/login_usecase.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;
  final AuthStorage _authStorage;

  LoginCubit(this._loginUseCase, this._authStorage) : super(LoginStates());

  void doIntent(LoginIntent intent) {
    switch (intent.runtimeType) {
      case PerformLogin:
        final user = intent as PerformLogin;
        _performLogin(
          email: user.email,
          password: user.password,
          rememberMe: user.rememberMe,
        );
        break;

      case ToggleRememberMe:
        emit(state.copyWith(
          rememberMe: (intent as ToggleRememberMe).value,
        ));
        break;
    }
  }

  Future<void> _performLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(
      loginResource: Resource.loading(),
    ));
      final result = await _loginUseCase.call(email, password);

      switch (result) {
        case SuccessApiResult<LoginModel>():
          if (rememberMe) {
            await _saveUserData(result.data);
          }
          await _authStorage.saveToken(result.data.token);
          emit(state.copyWith(
            loginResource: Resource.success(result.data),
          ));
          break;

        case ErrorApiResult<LoginModel>():
          //print('Login Error: ${result.error}');
          emit(state.copyWith(
            loginResource: Resource.error(result.error),
          ));
          break;
      }
  }

  Future<void> _saveUserData(LoginModel model) async {
    await _authStorage.saveUser(model.user);
  }
}

