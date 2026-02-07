abstract class AuthEvents {}

class SignupEvent extends AuthEvents {}

class FirstNameChangedEvent extends AuthEvents {
  final String? firstName;
  FirstNameChangedEvent({this.firstName});
}

class LastNameChangedEvent extends AuthEvents {
  final String? lastName;
  LastNameChangedEvent({this.lastName});
}

class EmailChangedEvent extends AuthEvents {
  final String? email;
  EmailChangedEvent({this.email});
}

class PasswordChangedEvent extends AuthEvents {
  final String? password;
  PasswordChangedEvent({this.password});
}

class ConfirmPasswordChangedEvent extends AuthEvents {
  final String? confirmPassword;
  ConfirmPasswordChangedEvent({this.confirmPassword});
}

class PhoneChangedEvent extends AuthEvents {
  final String? phone;
  PhoneChangedEvent({this.phone});
}

class GenderChangedEvent extends AuthEvents {
  final String? gender;
  GenderChangedEvent({this.gender});
}

sealed class RegisterUiEvents {}

class NavigateToLoginEvent extends RegisterUiEvents {}

class ShowSuccessDialogEvent extends RegisterUiEvents {}

class ShowErrorDialogEvent extends RegisterUiEvents {
  final String? errorMessage;
  ShowErrorDialogEvent({this.errorMessage});
}
