import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/editProfile_repo.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/edit_profile_usecase.dart';

@GenerateMocks([EditprofileRepo])
import 'edit_profile_usecase_test.mocks.dart';

void main() {
  late MockEditprofileRepo mockRepo;
  late EditProfileUseCase useCase;

  setUpAll(() {
    mockRepo = MockEditprofileRepo();
    useCase = EditProfileUseCase(mockRepo);

    provideDummy<ApiResult<EditProfileResponse>>(
      SuccessApiResult(data: EditProfileResponse(message: '')),
    );
  });

  group('EditProfileUseCase', () {
    final fakeResponse = EditProfileResponse(
      message: 'Profile updated successfully',
    );

    test('returns SuccessApiResult when repo returns success', () async {
      // arrange
      when(
        mockRepo.editProfile(
          token: anyNamed('token'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult<EditProfileResponse>(data: fakeResponse),
      );

      // act
      final result = await useCase.call(
        token: 'fake_token',
        firstName: 'Ali',
        lastName: 'Besar',
        email: 'ali@test.com',
        phone: '+20100000000',
      );

      // assert
      expect(result, isA<SuccessApiResult<EditProfileResponse>>());

      final data = (result as SuccessApiResult<EditProfileResponse>).data;
      expect(data.message, fakeResponse.message);

      verify(
        mockRepo.editProfile(
          token: 'fake_token',
          firstName: 'Ali',
          lastName: 'Besar',
          email: 'ali@test.com',
          phone: '+20100000000',
        ),
      ).called(1);
    });

    test('returns ErrorApiResult when repo returns error', () async {
      // arrange
      when(
        mockRepo.editProfile(
          token: anyNamed('token'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer(
        (_) async =>
            ErrorApiResult<EditProfileResponse>(error: 'Edit profile failed'),
      );

      // act
      final result = await useCase.call(
        token: 'fake_token',
        firstName: 'Ali',
        lastName: 'Besar',
        email: 'ali@test.com',
        phone: '+20100000000',
      );

      // assert
      expect(result, isA<ErrorApiResult<EditProfileResponse>>());

      final error = (result as ErrorApiResult<EditProfileResponse>).error;
      expect(error, 'Edit profile failed');

      verify(
        mockRepo.editProfile(
          token: 'fake_token',
          firstName: 'Ali',
          lastName: 'Besar',
          email: 'ali@test.com',
          phone: '+20100000000',
        ),
      ).called(1);
    });
  });
}
