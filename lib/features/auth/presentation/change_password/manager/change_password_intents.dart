sealed class ChangePasswordIntent {
  const ChangePasswordIntent();

  static const formChanged = FormChangedIntent();
  static const toggleCurrentPasswordVisibility =
      ToggleCurrentPasswordVisibility();
  static const toggleNewPasswordVisibility = ToggleNewPasswordVisibility();
  static const toggleConfirmPasswordVisibility =
      ToggleConfirmPasswordVisibility();

  static const submit = SubmitChangePasswordIntent();
}

class FormChangedIntent extends ChangePasswordIntent {
  const FormChangedIntent();
}

class ToggleCurrentPasswordVisibility extends ChangePasswordIntent {
  const ToggleCurrentPasswordVisibility();
}

class ToggleNewPasswordVisibility extends ChangePasswordIntent {
  const ToggleNewPasswordVisibility();
}

class ToggleConfirmPasswordVisibility extends ChangePasswordIntent {
  const ToggleConfirmPasswordVisibility();
}

class SubmitChangePasswordIntent extends ChangePasswordIntent {
  const SubmitChangePasswordIntent();
}
