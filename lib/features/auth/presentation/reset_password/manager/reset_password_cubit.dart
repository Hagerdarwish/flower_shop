import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/auth/presentation/reset_password/manager/reset_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/network/api_result.dart';
import '../../../data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../../domain/models/reset_password_entity.dart';
import '../../../domain/usecase/reset_password_usecase.dart';

part 'reset_password_state.dart';
@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(ResetPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();

  void doIntent(ResetPasswordIntent intent) {
    switch (intent) {
      case FormChangedIntent():
        _validateForm();
        break;
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisibility();
        break;
      case SubmitResetPasswordIntent():
        _submitResetPassword();
        break;
    }
  }

  void _validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    emit(state.copyWith(isFormValid: isValid));
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(
      togglePasswordVisibility:
      !state.togglePasswordVisibility,
    ));
  }

  Future<void> _submitResetPassword() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    emit(state.copyWith(resource: Resource.loading()));

    final dto = ResetPasswordRequest(
      email: emailController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );

    final result = await _resetPasswordUseCase(dto);

    if (result is SuccessApiResult<ResetPasswordEntity>) {
      emit(state.copyWith(
        resource: Resource.success(result.data),
      ));
    } else if (result is ErrorApiResult<ResetPasswordEntity>) {
      emit(state.copyWith(
        resource: Resource.error(result.error),
      ));
    } else {
      emit(state.copyWith(
        resource: Resource.error('Unexpected error'),
      ));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
    return super.close();
  }
}
