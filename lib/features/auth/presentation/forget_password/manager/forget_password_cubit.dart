import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/network/api_result.dart';
import '../../../domain/models/forget_password_entity.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/forgot_password_usecase.dart';

part 'forget_password_state.dart';
part 'forget_password_intents.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgotPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordCubit(this._forgetPasswordUseCase)
    : super(ForgetPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void doIntent(ForgetPasswordIntents intent) {
    switch (intent) {
      case FormChangedIntent():
        _validateForm();
        break;
      case SubmitForgetPasswordIntent():
        _submitForgetPassword();
        break;
    }
  }

  void _validateForm() {
    final isEmailFilled = emailController.text.trim().isNotEmpty;
    emit(state.copyWith(isFormValid: isEmailFilled));
  }

  Future<void> _submitForgetPassword() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    emit(state.copyWith(resource: Resource.loading()));
    final result = await _forgetPasswordUseCase(emailController.text.trim());

    if (result is SuccessApiResult<ForgotPasswordEntity>) {
      final entity = result.data;

      if (entity.message.toLowerCase().contains('success')) {
        emit(state.copyWith(resource: Resource.success(entity)));
      } else {
        emit(state.copyWith(resource: Resource.error(entity.message)));
      }
    } else if (result is ErrorApiResult<ForgotPasswordEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error('Unexpected error')));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
