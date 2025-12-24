import 'package:bloc/bloc.dart';
import 'package:flower_shop/app/features/auth/presentation/reset_code/manager/reset_code_intent.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/network/api_result.dart';
import '../../../domain/models/forget_password_entity.dart';
import '../../../domain/models/reset_code_entity.dart';
import '../../../domain/usecase/forgot_password_usecase.dart';
import '../../../domain/usecase/verify_reset_code_usecase.dart';

part 'reset_code_state.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyUseCase;
  final ForgotPasswordUseCase _resendUseCase;
  final String email;

  VerifyResetCodeCubit(
      this._verifyUseCase,
      this._resendUseCase,
      @factoryParam this.email)
      : super(VerifyResetCodeState.initial());

  void doIntent(VerifyResetCodeIntents intent) {
    switch (intent.runtimeType) {
      case FormChangedIntent:
        _validateForm((intent as FormChangedIntent).code);
        break;
      case SubmitVerifyCodeIntent:
        _submitCode();
        break;
      case ResendCodeIntent:
        _resendCode();
        break;
    }
  }

  void _validateForm(String code) {
    emit(state.copyWith(
      code: code,
      isFormValid: code.length == 6,
    ));
  }

  Future<void> _submitCode() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(resource: Resource.loading()));

    final result = await _verifyUseCase(state.code);

    if (result is SuccessApiResult<ResetCodeEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<ResetCodeEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error("Unexpected error")));
    }
  }

  Future<void> _resendCode() async {
    emit(state.copyWith(resource: Resource.loading()));

    final result = await _resendUseCase(email);

    if (result is SuccessApiResult<ForgotPasswordEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<ForgotPasswordEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error("Unexpected error")));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

