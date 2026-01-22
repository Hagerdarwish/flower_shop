import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/datascources/editProfileDataScource.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/data/repos/editprofileRepoImpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'editprofileRepoImpl_test.mocks.dart';

@GenerateMocks([EditProfileDataSource])
void main() {
  late EditprofileRepoImpl repo;
  late MockEditProfileDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockEditProfileDataSource();
    repo = EditprofileRepoImpl(mockDataSource);
  });

  const tToken = 'Bearer token';

  group('EditprofileRepoImpl Unit Tests', () {
    // ===== editProfile success =====
    test(
      'editProfile returns SuccessApiResult when datasource succeeds',
      () async {
        final user = User(
          id: '1',
          firstName: 'Ali',
          lastName: 'Mohamed',
          email: 'ali@test.com',
          phone: '123456789',
        );
        final response = EditProfileResponse(
          message: 'Profile updated',
          user: user,
        );

        when(
          mockDataSource.editProfile(
            token: anyNamed('token'),
            request: anyNamed('request'),
          ),
        ).thenAnswer((_) async => response);

        final result = await repo.editProfile(
          token: tToken,
          firstName: 'Ali',
          lastName: 'Mohamed',
          email: 'ali@test.com',
          phone: '123456789',
        );

        expect(result, isA<SuccessApiResult<EditProfileResponse>>());
        expect((result as SuccessApiResult).data.user?.firstName, 'Ali');
        verify(
          mockDataSource.editProfile(
            token: anyNamed('token'),
            request: anyNamed('request'),
          ),
        ).called(1);
      },
    );

    // ===== editProfile error =====
    test('editProfile returns ErrorApiResult when datasource throws', () async {
      when(
        mockDataSource.editProfile(
          token: anyNamed('token'),
          request: anyNamed('request'),
        ),
      ).thenThrow(Exception('error'));

      final result = await repo.editProfile(token: tToken);

      expect(result, isA<ErrorApiResult>());
      expect((result as ErrorApiResult).error, isNotEmpty);
    });

    // ===== uploadPhoto success =====
    test(
      'uploadPhoto returns SuccessApiResult when datasource succeeds',
      () async {
        final photoFile = XFile.fromData(
          Uint8List.fromList([1, 2, 3]),
          name: 'photo.jpg',
        );

        final user = User(
          id: '1',
          firstName: 'Ali',
          lastName: 'Mohamed',
          email: 'ali@test.com',
          phone: '123456789',
          photo: 'photo.jpg',
        );
        final response = EditProfileResponse(
          message: 'Photo uploaded',
          user: user,
        );

        when(
          mockDataSource.uploadPhoto(
            token: anyNamed('token'),
            photo: anyNamed('photo'),
          ),
        ).thenAnswer((_) async => response);

        final result = await repo.uploadPhoto(token: tToken, photo: photoFile);

        expect(result, isA<SuccessApiResult<EditProfileResponse>>());
        expect((result as SuccessApiResult).data.user?.photo, 'photo.jpg');
        verify(
          mockDataSource.uploadPhoto(
            token: anyNamed('token'),
            photo: anyNamed('photo'),
          ),
        ).called(1);
      },
    );

    // ===== uploadPhoto error =====
    test('uploadPhoto returns ErrorApiResult when repo fails', () async {
      final photoFile = XFile.fromData(
        Uint8List.fromList([1, 2, 3]),
        name: 'photo.jpg',
      );

      when(
        mockDataSource.uploadPhoto(
          token: anyNamed('token'),
          photo: anyNamed('photo'),
        ),
      ).thenThrow(Exception('error'));

      final result = await repo.uploadPhoto(token: tToken, photo: photoFile);

      expect(result, isA<ErrorApiResult>());
      expect((result as ErrorApiResult).error, isNotEmpty);
    });
  });
}
