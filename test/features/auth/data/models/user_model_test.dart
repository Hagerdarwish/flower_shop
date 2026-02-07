import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/auth/data/models/response/user_model.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart'
    as domain;

void main() {
  group("User.toEntity()", () {
    test("should convert User to UserModel correctly", () {
      final user = User(
        Id: "123",
        firstName: "Nouran",
        lastName: "Samer",
        email: "test@email.com",
        phone: "0100",
        role: "user",
        wishlist: ["item1", "item2"],
        addresses: ["addr1"],
        photo: "photo_url",
        gender: "female",
        createdAt: "2024-01-01",
      );

      final model = user.toEntity();

      expect(model, isA<domain.UserModel>());
      expect(model.id, "123");
      expect(model.firstName, "Nouran");
      expect(model.lastName, "Samer");
      expect(model.email, "test@email.com");
      expect(model.role, "user");
      expect(model.wishlist, ["item1", "item2"]);
      expect(model.photo, "photo_url");
    });

    test("should return default values when User fields are null", () {
      final user = User();

      final model = user.toEntity();

      expect(model.id, "");
      expect(model.firstName, "");
      expect(model.lastName, null);
      expect(model.email, "");
      expect(model.role, "");
      expect(model.wishlist, null);
      expect(model.photo, null);
    });
  });

  group("User.fromJson and toJson", () {
    test("fromJson should parse JSON correctly", () {
      final json = {
        "_id": "1",
        "firstName": "Nouran",
        "lastName": "Samer",
        "email": "x@y.com",
        "role": "user",
        "wishlist": [],
      };

      final user = User.fromJson(json);

      expect(user.Id, "1");
      expect(user.firstName, "Nouran");
      expect(user.lastName, "Samer");
      expect(user.email, "x@y.com");
      expect(user.role, "user");
      expect(user.wishlist, []);
    });

    test("toJson should convert User to JSON correctly", () {
      final user = User(
        Id: "1",
        firstName: "Nouran",
        lastName: "Samer",
        email: "x@y.com",
        role: "user",
        wishlist: [],
      );

      final json = user.toJson();

      expect(json["_id"], "1");
      expect(json["firstName"], "Nouran");
      expect(json["lastName"], "Samer");
      expect(json["email"], "x@y.com");
      expect(json["role"], "user");
      expect(json["wishlist"], []);
    });
  });
}
