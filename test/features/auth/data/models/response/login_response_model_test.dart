import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/auth/data/models/response/user_model.dart'
    as data;
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';

void main() {
  group("User.toEntity()", () {
    test("should convert User to UserModel correctly", () {
      final user = data.User(
        Id: "123",
        firstName: "Nouran",
        lastName: "Samer",
        email: "test@email.com",
        photo: null,
        role: "student",
        wishlist: [],
      );

      final model = user.toEntity();

      expect(model, isA<UserModel>());
      expect(model.id, "123");
      expect(model.firstName, "Nouran");
      expect(model.role, "student");
    });

    test("should return default values when User fields are null", () {
      final user = data.User();

      final model = user.toEntity();

      expect(model.id, "");
      expect(model.firstName, "");
      expect(model.role, "");
      expect(model.wishlist, null);
    });
  });

  group("LoginResponse.toEntity()", () {
    test("should convert full LoginResponse to LoginModel", () {
      final response = LoginResponse(
        message: "success",
        token: "abc123",
        user: data.User(
          Id: "1",
          firstName: "Nour",
          lastName: "Samer",
          email: "x@y.com",
          photo: null,
          role: "student",
          wishlist: [],
        ),
      );

      final model = response.toEntity();

      expect(model, isA<LoginModel>());
      expect(model.message, "success");
      expect(model.token, "abc123");
      expect(model.user.firstName, "Nour");
      expect(model.user.role, "student");
    });

    test("should return default UserModel when user is null", () {
      final response = LoginResponse(message: "ok", token: "tkn", user: null);

      final model = response.toEntity();

      expect(model.user.id, "");
      expect(model.user.firstName, "");
      expect(model.user.role, "");
      expect(model.user.wishlist, []);
    });
  });
}
