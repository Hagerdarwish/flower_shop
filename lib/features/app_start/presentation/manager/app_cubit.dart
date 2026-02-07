import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'app_states.dart';
import 'app_intent.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  final AuthStorage _authStorage;

  AppCubit(this._authStorage) : super(AppState.initial());

  void doIntent(AppIntent intent) {
    if (intent is CheckAuth) {
      _checkAuth();
    }
  }

  Future<void> _checkAuth() async {
    emit(state.copyWith(authResource: Resource.loading()));
    try {
      final rememberMe = await _authStorage.getRememberMe();
      emit(state.copyWith(authResource: Resource.success(rememberMe)));
    } catch (e) {
      emit(state.copyWith(authResource: Resource.error(e.toString())));
    }
  }
}
