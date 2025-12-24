part of 'forget_password_cubit.dart';

class ForgetPasswordState {
  final Resource<ForgotPasswordEntity> resource;
  final bool isFormValid;
  const ForgetPasswordState({
    required this.resource,
    required this.isFormValid,
  });
  factory ForgetPasswordState.initial() =>
      ForgetPasswordState(resource: Resource.initial(), isFormValid: false);
  ForgetPasswordState copyWith({
    Resource<ForgotPasswordEntity>? resource,
    bool? isFormValid,
  }) {
    return ForgetPasswordState(
      resource: resource ?? this.resource,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
