import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_intent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/edit_profile_usecase.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  final EditProfileUseCase _editProfileUseCase;
  final AuthStorage _authStorage;

  EditProfileCubit(this._editProfileUseCase, this._authStorage)
    : super(EditProfileStates());

  void doIntent(EditProfileIntent intent) {
    switch (intent.runtimeType) {
      case PerformEditProfile:
        final data = intent as PerformEditProfile;
        _editProfile(data);
        break;
    }
  }

  Future<void> _editProfile(PerformEditProfile intent) async {
    emit(state.copyWith(editProfileResource: Resource.loading()));

    final result = await _editProfileUseCase(
      token: intent.token,
      firstName: intent.firstName,
      lastName: intent.lastName,
      email: intent.email,
      phone: intent.phone,
    );

    if (isClosed) return;
    switch (result) {
      case SuccessApiResult<EditProfileResponse>():
        final updatedUser = result.data.user;
        if (updatedUser != null) {
          await _authStorage.saveUser(
            UserModel.fromEditProfileUser(updatedUser),
          );
        }
        emit(
          state.copyWith(editProfileResource: Resource.success(result.data)),
        );
        break;

      case ErrorApiResult<EditProfileResponse>():
        emit(state.copyWith(editProfileResource: Resource.error(result.error)));
        break;
    }
  }
}
