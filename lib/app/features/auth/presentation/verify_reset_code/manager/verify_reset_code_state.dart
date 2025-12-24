part of 'verify_reset_code_cubit.dart';
class VerifyResetCodeState {
  final Resource<dynamic> resource;
  final bool isFormValid;
  final String code;

  const VerifyResetCodeState({
    required this.resource,
    required this.isFormValid,
    required this.code,
  });

  factory VerifyResetCodeState.initial() => VerifyResetCodeState(
    resource: Resource.initial(),
    isFormValid: false,
    code: '',
  );

  VerifyResetCodeState copyWith({
    Resource<dynamic>? resource,
    bool? isFormValid,
    String? code,
  }) {
    return VerifyResetCodeState(
      resource: resource ?? this.resource,
      isFormValid: isFormValid ?? this.isFormValid,
      code: code ?? this.code,
    );
  }
}