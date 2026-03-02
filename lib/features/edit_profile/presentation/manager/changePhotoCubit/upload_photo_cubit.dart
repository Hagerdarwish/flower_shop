import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_intent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/upload_photo_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final AuthStorage _authStorage;

  UploadPhotoCubit(this._uploadPhotoUseCase, this._authStorage)
    : super(UploadPhotoState());

  void doIntent(UploadPhotoIntent intent) {
    if (intent is SelectPhotoIntent) {
      _selectPhoto(intent);
    } else if (intent is UploadSelectedPhotoIntent) {
      _uploadPhoto(intent);
    }
  }

  void _selectPhoto(SelectPhotoIntent intent) {
    emit(state.copyWith(selectedPhoto: intent.photo));
  }

  void _uploadPhoto(UploadSelectedPhotoIntent intent) async {
    if (state.selectedPhoto == null) return;

    emit(state.copyWith(uploadPhotoResource: Resource.loading()));

    final result = await _uploadPhotoUseCase.call(
      token: intent.token,
      photo: state.selectedPhoto!,
    );

    if (isClosed) return;
    if (result is SuccessApiResult<EditProfileResponse>) {
      final updatedUser = result.data.user;
      if (updatedUser != null) {
        await _authStorage.saveUser(UserModel.fromEditProfileUser(updatedUser));
      }

      emit(
        state.copyWith(
          selectedPhoto: null, // Clear local preview once uploaded
          uploadPhotoResource: Resource.success(result.data),
        ),
      );
    } else if (result is ErrorApiResult<EditProfileResponse>) {
      emit(state.copyWith(uploadPhotoResource: Resource.error(result.error)));
    }
  }
}
