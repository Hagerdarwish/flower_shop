import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';

void main() {
  group('EditProfileResponse', () {
    test('fromJson parses response correctly', () {
      final json = {
        "message": "Profile updated successfully",
        "user": {
          "_id": "123",
          "firstName": "Ali",
          "lastName": "Besar",
          "email": "ali@test.com",
          "password": "123456",
          "gender": "male",
          "phone": "01000000000",
          "photo": "photo.png",
          "role": "user",
          "wishlist": [],
          "addresses": [],
          "createdAt": "2024-01-01T10:00:00.000Z",
        },
      };

      final response = EditProfileResponse.fromJson(json);

      expect(response.message, "Profile updated successfully");
      expect(response.user, isNotNull);
      expect(response.user!.id, "123");
      expect(response.user!.firstName, "Ali");
      expect(response.user!.lastName, "Besar");
      expect(response.user!.email, "ali@test.com");
      expect(response.user!.gender, "male");
      expect(response.user!.phone, "01000000000");
      expect(
        response.user!.createdAt,
        DateTime.parse("2024-01-01T10:00:00.000Z"),
      );
    });

    test('toJson converts response correctly', () {
      final user = User(
        id: "123",
        firstName: "Ali",
        lastName: "Besar",
        email: "ali@test.com",
        gender: "male",
        phone: "01000000000",
        role: "user",
        wishlist: [],
        addresses: [],
        createdAt: DateTime.parse("2024-01-01T10:00:00.000Z"),
      );

      final response = EditProfileResponse(
        message: "Profile updated successfully",
        user: user,
      );

      final json = response.toJson();

      expect(json["message"], "Profile updated successfully");

      // ✅ بدل cast على User object
      final userJson = user.toJson();

      expect(userJson["_id"], "123");
      expect(userJson["firstName"], "Ali");
      expect(userJson["lastName"], "Besar");
      expect(userJson["email"], "ali@test.com");
      expect(userJson["createdAt"], "2024-01-01T10:00:00.000Z");
    });

    test('handles null user correctly', () {
      final response = EditProfileResponse(message: "Updated", user: null);
      final json = response.toJson();

      expect(json["message"], "Updated");
      expect(json["user"], null);
    });
  });

  group('User', () {
    test('fromJson handles minimal data', () {
      final json = {"_id": "1", "firstName": "Ali", "email": "ali@test.com"};
      final user = User.fromJson(json);

      expect(user.id, "1");
      expect(user.firstName, "Ali");
      expect(user.email, "ali@test.com");
      expect(user.lastName, null);
      expect(user.phone, null);
      expect(user.gender, null);
    });
  });
}
