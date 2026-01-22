// upload_photo_usecase_test.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/editProfile_repo.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/upload_photo_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_usecase_test.mocks.dart';

@GenerateMocks([EditprofileRepo])
void main() {
  // 👈 حل مشكلة MissingDummyValueError
  provideDummy<ApiResult<EditProfileResponse>>(
    SuccessApiResult(data: EditProfileResponse(message: 'dummy')),
  );

  late MockEditprofileRepo mockRepo;
  late UploadPhotoUseCase useCase;

  setUp(() {
    mockRepo = MockEditprofileRepo();
    useCase = UploadPhotoUseCase(mockRepo);
  });

  final tToken = 'token';
  final tPhoto = XFile('test/assets/test_image.jpg'); // dummy file
  final tResponse = EditProfileResponse(
    message: 'Photo uploaded',
    user: User(
      id: '123',
      firstName: 'Ali',
      lastName: 'Besar',
      email: 'ali@test.com',
    ),
  );

  test('should return SuccessApiResult when uploadPhoto succeeds', () async {
    // arrange
    when(
      mockRepo.uploadPhoto(token: tToken, photo: tPhoto),
    ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

    // act
    final result = await useCase.call(token: tToken, photo: tPhoto);

    // assert
    expect(result, isA<SuccessApiResult<EditProfileResponse>>());
    expect((result as SuccessApiResult).data.message, 'Photo uploaded');
    verify(mockRepo.uploadPhoto(token: tToken, photo: tPhoto)).called(1);
  });

  test('should return ErrorApiResult when uploadPhoto fails', () async {
    // arrange
    when(
      mockRepo.uploadPhoto(token: tToken, photo: tPhoto),
    ).thenAnswer((_) async => ErrorApiResult(error: 'Upload failed'));

    // act
    final result = await useCase.call(token: tToken, photo: tPhoto);

    // assert
    expect(result, isA<ErrorApiResult<EditProfileResponse>>());
    expect((result as ErrorApiResult).error, 'Upload failed');
    verify(mockRepo.uploadPhoto(token: tToken, photo: tPhoto)).called(1);
  });
}
