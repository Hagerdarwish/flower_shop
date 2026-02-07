import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';

extension SignupDtoMapper on SignupDto {
  SignupModel toSignupModel() {
    return SignupModel(
      message: message,
      token: token,
      user: user?.toUserModel(),
    );
  }
}

extension UserDtoMapper on UserDto {
  UserModel toUserModel() {
    return UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      id: id,
    );
  }
}
