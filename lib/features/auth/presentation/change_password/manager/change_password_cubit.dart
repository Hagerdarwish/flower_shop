import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/auth/presentation/change_password/manager/change_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/network/api_result.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../../../data/models/request/change-password-request-models/change-password-request-model.dart';
import '../../../domain/models/change_password_entity.dart';
import '../../../domain/usecase/change_password_usecase.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(ChangePasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void doIntent(ChangePasswordIntent intent) {
    switch (intent.runtimeType) {
      case FormChangedIntent:
        _validateForm();
        break;
      case ToggleCurrentPasswordVisibility:
        _toggleCurrentPasswordVisibility();
        break;
      case ToggleNewPasswordVisibility:
        _toggleNewPasswordVisibility();
        break;
      case ToggleConfirmPasswordVisibility:
        _toggleConfirmPasswordVisibility();
        break;
      case SubmitChangePasswordIntent:
        _submitChangePassword();
        break;
    }
  }

  void _validateForm() {
    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    final isValid =
        current.isNotEmpty &&
        newPass.isNotEmpty &&
        confirm.isNotEmpty &&
        Validators.validatePassword(newPass) == null &&
        newPass == confirm;

    emit(state.copyWith(isFormValid: isValid));
  }

  void _toggleCurrentPasswordVisibility() {
    emit(state.copyWith(currentPasswordVisible: !state.currentPasswordVisible));
  }

  void _toggleNewPasswordVisibility() {
    emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
  }

  void _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  Future<void> _submitChangePassword() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(resource: Resource.loading()));

    final dto = ChangePasswordRequest(
      password: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );

    final result = await _changePasswordUseCase(dto);

    if (result is SuccessApiResult<ChangePasswordEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<ChangePasswordEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error('Unexpected error')));
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
