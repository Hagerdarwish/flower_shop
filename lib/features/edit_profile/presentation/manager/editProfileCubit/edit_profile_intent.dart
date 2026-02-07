sealed class EditProfileIntent {}

class PerformEditProfile extends EditProfileIntent {
  final String token;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  PerformEditProfile({
    required this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });
}
