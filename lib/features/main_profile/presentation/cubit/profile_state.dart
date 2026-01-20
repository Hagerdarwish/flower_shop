// lib/features/main_profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  final String? message;

  const ProfileLoading([this.message]);
}

class ProfileLoaded extends ProfileState {
  final ProfileUserModel user;
  final String language;
  final bool notificationsEnabled;

  const ProfileLoaded({
    required this.user,
    required this.language,
    required this.notificationsEnabled,
  });
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

class LogoutSuccess extends ProfileState {}

// Navigation states
class NavigateToOrders extends ProfileState {}

class NavigateToAddresses extends ProfileState {}

class NavigateToAboutUs extends ProfileState {}

class NavigateToTerms extends ProfileState {}

// Dialog/BottomSheet states
class ShowLanguageSelection extends ProfileState {
  final String currentLanguage;

  const ShowLanguageSelection(this.currentLanguage);
}

class ShowLogoutConfirmation extends ProfileState {
  final ProfileUserModel user;
  final String language;
  final bool notificationsEnabled;

  const ShowLogoutConfirmation({
    required this.user,
    required this.language,
    required this.notificationsEnabled,
  });
}

class ShowAppVersion extends ProfileState {
  final String appVersion;

  const ShowAppVersion(this.appVersion);
}
