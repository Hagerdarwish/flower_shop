import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/auth/presentation/reset_password/manager/reset_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/network/api_result.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../../../data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../../domain/models/reset_password_entity.dart';
import '../../../domain/usecase/reset_password_usecase.dart';

part 'reset_password_state.dart';
@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  final String email;

  ResetPasswordCubit( @factoryParam this.email, this._resetPasswordUseCase)
      : super(ResetPasswordState.initial(email: email));

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
    final isValid = newPasswordController.text.trim().isNotEmpty &&
        Validators.validatePassword(newPasswordController.text.trim()) == null;

    emit(state.copyWith(isFormValid: isValid));
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(
      togglePasswordVisibility: !state.togglePasswordVisibility,
    ));
  }

  Future<void> _submitResetPassword() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(resource: Resource.loading()));

    final dto = ResetPasswordRequest(
      email: email, // Use the stored email
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