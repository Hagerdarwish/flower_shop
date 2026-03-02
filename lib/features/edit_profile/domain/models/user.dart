class SignupModel {
  final String? message;
  final UserModel? user;
  final String? token;
  final String? error;

  SignupModel({this.message, this.user, this.token, this.error});
}

class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? id;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.id,
  });
}
