sealed class VerifyResetCodeIntents {}

class FormChangedIntent extends VerifyResetCodeIntents {
  final String code;
  FormChangedIntent(this.code);
}

class SubmitVerifyCodeIntent extends VerifyResetCodeIntents {}

class ResendCodeIntent extends VerifyResetCodeIntents {}