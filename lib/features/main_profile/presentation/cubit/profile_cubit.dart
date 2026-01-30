// presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase _getCurrentUser;
  final AuthStorage _authStorage;

  ProfileCubit(this._getCurrentUser, this._authStorage)
    : super(ProfileState.initial());

  void doIntent(ProfileIntent intent) {
    if (intent is LoadProfileEvent) {
      _loadProfile();
    }
  }

  Future<void> _loadProfile() async {
    emit(state.copyWith(user: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null) {
      emit(state.copyWith(user: Resource.error('Token not found')));
      return;
    }

    final result = await _getCurrentUser("Bearer $token");

    switch (result) {
      case SuccessApiResult<ProfileUserModel>():
        emit(state.copyWith(user: Resource.success(result.data)));

      case ErrorApiResult<ProfileUserModel>():
        emit(state.copyWith(user: Resource.error(result.error.toString())));
    }
  }
}
