import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/auth/presentation/verify_reset_code/manager/verify_reset_code_intent.dart';
import 'package:injectable/injectable.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/network/api_result.dart';
import '../../../domain/models/forget_password_entity.dart';
import '../../../domain/models/verify_reset_code_entity.dart';
import '../../../domain/usecase/forgot_password_usecase.dart';
import '../../../domain/usecase/verify_reset_code_usecase.dart';

part 'verify_reset_code_state.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyUseCase;
  final ForgotPasswordUseCase _resendUseCase;
  final String email;
  Timer? _cooldownTimer;

  VerifyResetCodeCubit(
    this._verifyUseCase,
    this._resendUseCase,
    @factoryParam this.email,
  ) : super(VerifyResetCodeState.initial()) {
    _startCooldown(30);
  }

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
    emit(state.copyWith(code: code, isFormValid: code.length == 6));
  }

  Future<void> _submitCode() async {
    if (!state.isFormValid) return;

    emit(state.copyWith(resource: Resource.loading()));

    final result = await _verifyUseCase(state.code);

    if (result is SuccessApiResult<VerifyResetCodeEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<VerifyResetCodeEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error("Unexpected error")));
    }
  }

  Future<void> _resendCode() async {
    if (!state.canResend) return;
    _startCooldown(30);
    emit(state.copyWith(resource: Resource.loading(), canResend: false));

    final result = await _resendUseCase(email);

    if (result is SuccessApiResult<ForgotPasswordEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<ForgotPasswordEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error("Unexpected error")));
    }
  }

  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    emit(state.copyWith(resendCountdown: seconds, canResend: false));

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.resendCountdown - 1;
      if (remaining <= 0) {
        timer.cancel();
        emit(state.copyWith(resendCountdown: 0, canResend: true));
      } else {
        emit(state.copyWith(resendCountdown: remaining));
      }
    });
  }

  @override
  Future<void> close() {
    _cooldownTimer?.cancel();
    return super.close();
  }
}
