part of 'forget_password_cubit.dart';

sealed class ForgetPasswordIntents {
  const ForgetPasswordIntents();
}

class FormChangedIntent extends ForgetPasswordIntents {
  const FormChangedIntent();
}

class SubmitForgetPasswordIntent extends ForgetPasswordIntents {
  const SubmitForgetPasswordIntent();
}
