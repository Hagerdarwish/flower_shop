// editprofile_repo_test.dart
import 'dart:typed_data';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/datascources/editProfileDataScource.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/data/repos/editprofileRepoImpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'editProfileDataScource_imp_test.mocks.dart';

@GenerateMocks([EditProfileDataSource])
void main() {
  late MockEditProfileDataSource mockDataSource;
  late EditprofileRepoImpl repo;

  setUp(() {
    mockDataSource = MockEditProfileDataSource();
    repo = EditprofileRepoImpl(mockDataSource);
  });

  final tToken = 'token';
  final tRequest = EditProfileRequest(
    firstName: 'Ali',
    lastName: 'Besar',
    email: 'ali@test.com',
    phone: '01000000000',
  );

  final tResponse = EditProfileResponse(
    message: 'Profile updated',
    user: User(
      id: '123',
      firstName: 'Ali',
      lastName: 'Besar',
      email: 'ali@test.com',
    ),
  );

  final tPhoto = XFile.fromData(
    Uint8List.fromList([1, 2, 3]),
    name: 'test.jpg',
  );

  group('editProfile', () {
    test('should return SuccessApiResult when DataSource succeeds', () async {
      // arrange
      when(
        mockDataSource.editProfile(token: tToken, request: anyNamed('request')),
      ).thenAnswer((_) async => tResponse);

      // act
      final result = await repo.editProfile(
        token: tToken,
        firstName: 'Ali',
        lastName: 'Besar',
        email: 'ali@test.com',
        phone: '01000000000',
      );

      // assert
      expect(result, isA<SuccessApiResult<EditProfileResponse>>());
      expect((result as SuccessApiResult).data.message, 'Profile updated');
      verify(
        mockDataSource.editProfile(token: tToken, request: anyNamed('request')),
      ).called(1);
    });

    test('should return ErrorApiResult when DataSource throws', () async {
      // arrange
      when(
        mockDataSource.editProfile(token: tToken, request: anyNamed('request')),
      ).thenThrow(Exception('API Error'));

      // act
      final result = await repo.editProfile(token: tToken);

      // assert
      expect(result, isA<ErrorApiResult>());
      verify(
        mockDataSource.editProfile(token: tToken, request: anyNamed('request')),
      ).called(1);
    });
  });

  group('uploadPhoto', () {
    test('should return SuccessApiResult when DataSource succeeds', () async {
      // arrange
      when(
        mockDataSource.uploadPhoto(
          token: anyNamed('token'),
          photo: anyNamed('photo'),
        ),
      ).thenAnswer((_) async => tResponse);

      // act
      final result = await repo.uploadPhoto(token: tToken, photo: tPhoto);

      // assert
      expect(result, isA<SuccessApiResult<EditProfileResponse>>());
      expect((result as SuccessApiResult).data.message, 'Profile updated');
      verify(
        mockDataSource.uploadPhoto(
          token: anyNamed('token'),
          photo: anyNamed('photo'),
        ),
      ).called(1);
    });

    test('should return ErrorApiResult when DataSource throws', () async {
      // arrange
      when(
        mockDataSource.uploadPhoto(
          token: anyNamed('token'),
          photo: anyNamed('photo'),
        ),
      ).thenThrow(Exception('API Error'));

      // act
      final result = await repo.uploadPhoto(token: tToken, photo: tPhoto);

      // assert
      expect(result, isA<ErrorApiResult>());
      verify(
        mockDataSource.uploadPhoto(
          token: anyNamed('token'),
          photo: anyNamed('photo'),
        ),
      ).called(1);
    });
  });
}
