part of 'reset_password_cubit.dart';


class ResetPasswordState {
  final Resource<ResetPasswordEntity> resource;
  final bool isFormValid;
  final bool togglePasswordVisibility;

  const ResetPasswordState({
    required this.resource,
    required this.isFormValid,
    required this.togglePasswordVisibility,
  });

  factory ResetPasswordState.initial() =>
      ResetPasswordState(
        resource: Resource.initial(),
        isFormValid: false,
        togglePasswordVisibility: false,
      );

  ResetPasswordState copyWith({
    Resource<ResetPasswordEntity>? resource,
    bool? isFormValid,
    bool? togglePasswordVisibility,
  }) {
    return ResetPasswordState(
      resource: resource ?? this.resource,
      isFormValid: isFormValid ?? this.isFormValid,
      togglePasswordVisibility:
      togglePasswordVisibility ??
          this.togglePasswordVisibility,
    );
  }
}
