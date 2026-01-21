// presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final AuthStorage authStorage;

  ProfileCubit({required this.getCurrentUserUsecase, required this.authStorage})
    : super(ProfileInitial());

  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());

      final token = await authStorage.getToken();
      if (token == null) {
        emit(const ProfileError('Token not found'));
        return;
      }

      final apiResult = await getCurrentUserUsecase("Bearer $token");

      if (apiResult is SuccessApiResult<ProfileUserModel>) {
        emit(ProfileLoaded(apiResult.data));
      } else if (apiResult is ErrorApiResult<ProfileUserModel>) {
        emit(ProfileError(apiResult.error));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
