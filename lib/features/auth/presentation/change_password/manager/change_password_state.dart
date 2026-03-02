part of 'change_password_cubit.dart';

class ChangePasswordState {
  final Resource<ChangePasswordEntity> resource;
  final bool isFormValid;
  final bool currentPasswordVisible;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;

  const ChangePasswordState({
    required this.resource,
    required this.isFormValid,
    required this.currentPasswordVisible,
    required this.newPasswordVisible,
    required this.confirmPasswordVisible,
  });

  factory ChangePasswordState.initial() => ChangePasswordState(
    resource: Resource.initial(),
    isFormValid: false,
    currentPasswordVisible: false,
    newPasswordVisible: false,
    confirmPasswordVisible: false,
  );

  ChangePasswordState copyWith({
    Resource<ChangePasswordEntity>? resource,
    bool? isFormValid,
    bool? currentPasswordVisible,
    bool? newPasswordVisible,
    bool? confirmPasswordVisible,
  }) {
    return ChangePasswordState(
      resource: resource ?? this.resource,
      isFormValid: isFormValid ?? this.isFormValid,
      currentPasswordVisible:
          currentPasswordVisible ?? this.currentPasswordVisible,
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }
}
