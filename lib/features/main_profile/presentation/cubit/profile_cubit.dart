// lib/features/main_profile/presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  // final SetLanguageUseCase setLanguageUseCase;
  // final ToggleNotificationUseCase toggleNotificationUseCase;

  ProfileCubit({
    required this.getCurrentUserUsecase,
    // required this.setLanguageUseCase,
    // required this.toggleNotificationUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final result = await getCurrentUserUsecase();

    // Pattern matching without when method
    if (result is SuccessApiResult<ProfileUserModel>) {
      final user = result.data;
      final language = 'English'; // Default
      final notificationsEnabled = true; // Default

      emit(
        ProfileLoaded(
          user: user,
          language: language,
          notificationsEnabled: notificationsEnabled,
        ),
      );
    } else if (result is ErrorApiResult<ProfileUserModel>) {
      emit(ProfileError(result.error));
    }
  }

  // Future<void> changeLanguage(String languageCode) async {
  //   final currentState = state;
  //   if (currentState is ProfileLoaded) {
  //     await setLanguageUseCase(languageCode);

  //     final newLanguage = languageCode == 'en' ? 'English' : 'Arabic';

  //     emit(ProfileLoaded(
  //       user: currentState.user,
  //       language: newLanguage,
  //       notificationsEnabled: currentState.notificationsEnabled,
  //     ));
  //   }
  // }

  // Future<void> toggleNotifications(bool enable) async {
  //   final currentState = state;
  //   if (currentState is ProfileLoaded) {
  //     await toggleNotificationUseCase(enable);

  //     emit(ProfileLoaded(
  //       user: currentState.user,
  //       language: currentState.language,
  //       notificationsEnabled: enable,
  //     ));
  //   }
  // }
}
