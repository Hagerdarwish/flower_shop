import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart'
    as response;

class UserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String? photo;
  final String role;
  final String? phone;
  final String? gender;
  final List<dynamic>? wishlist;

  const UserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    this.photo,
    required this.role,
    this.phone,
    this.gender,
    this.wishlist,
  });

  factory UserModel.fromEditProfileUser(response.User user) {
    return UserModel(
      id: user.id ?? '',
      firstName: user.firstName ?? '',
      lastName: user.lastName,
      email: user.email ?? '',
      photo: user.photo,
      role: user.role ?? 'user',
      phone: user.phone,
      gender: user.gender,
      wishlist: user.wishlist,
    );
  }
}
