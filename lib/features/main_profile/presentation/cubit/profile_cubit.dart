// presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_about_section_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_terms_section_usecase.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase _getCurrentUser;
  final AuthStorage _authStorage;
  final GetAboutSectionUsecase _getAboutSections;
  final GetTermsSectionUsecase _getTerms;

  ProfileCubit(
    this._getCurrentUser,
    this._authStorage,
    this._getAboutSections,
    this._getTerms,
  ) : super(ProfileState.initial());

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

  Future<void> loadAboutData() async {
    emit(state.copyWith(about: Resource.loading()));
    try {
      final data = await _getAboutSections.call();
      emit(state.copyWith(about: Resource.success(data)));
    } catch (e) {
      emit(state.copyWith(about: Resource.error(e.toString())));
    }
  }

  Future<void> loadTermsData() async {
    emit(state.copyWith(terms: Resource.loading()));
    try {
      final data = await _getTerms.call();
      emit(state.copyWith(terms: Resource.success(data)));
    } catch (e) {
      emit(state.copyWith(terms: Resource.error(e.toString())));
    }
  }
}
