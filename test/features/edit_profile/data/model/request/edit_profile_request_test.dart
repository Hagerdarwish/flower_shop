import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileRequest', () {
    test('toJson returns correct map', () {
      // arrange
      final request = EditProfileRequest(
        firstName: 'Ali',
        lastName: 'Besar',
        email: 'ali@test.com',
        phone: '01000000000',
      );

      // act
      final json = request.toJson();

      // assert
      expect(json, {
        'firstName': 'Ali',
        'lastName': 'Besar',
        'email': 'ali@test.com',
        'phone': '01000000000',
      });
    });

    test('fromJson returns correct object', () {
      // arrange
      final json = {
        'firstName': 'Ali',
        'lastName': 'Besar',
        'email': 'ali@test.com',
        'phone': '01000000000',
      };

      // act
      final request = EditProfileRequest.fromJson(json);

      // assert
      expect(request.firstName, 'Ali');
      expect(request.lastName, 'Besar');
      expect(request.email, 'ali@test.com');
      expect(request.phone, '01000000000');
    });

    test('handles null values correctly', () {
      // arrange
      final request = EditProfileRequest(
        firstName: null,
        lastName: null,
        email: null,
        phone: null,
      );

      // act
      final json = request.toJson();

      // assert
      expect(json, {
        'firstName': null,
        'lastName': null,
        'email': null,
        'phone': null,
      });
    });
  });
}
