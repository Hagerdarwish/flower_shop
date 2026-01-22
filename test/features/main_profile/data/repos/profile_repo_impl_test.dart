import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/datasource/profile_remote_data_source.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/repos/profile_repo_impl.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileremoteDataSource])
void main() {
  // Provide dummy so Mockito works with generic ApiResult<ProfileResponse>
  provideDummy<ApiResult<ProfileResponse>>(
    SuccessApiResult(
      data: ProfileResponse(message: "", profileUserModel: ProfileUserModel()),
    ),
  );

  late MockProfileremoteDataSource mockRemote;
  late ProfileRepoImpl repo;

  setUp(() {
    mockRemote = MockProfileremoteDataSource();
    repo = ProfileRepoImpl(profileRemoteDataSource: mockRemote);
  });

  test('returns SuccessApiResult<ProfileUserModel> on success', () async {
    const token = "Bearer token";

    final response = ProfileResponse(
      message: "success",
      profileUserModel: ProfileUserModel(
        id: "1",
        firstName: "Rahma",
        email: "rahma@test.com",
      ),
    );

    when(
      mockRemote.getProfile(token),
    ).thenAnswer((_) async => SuccessApiResult(data: response));

    final result = await repo.getCurrentUser(token);

    expect(result, isA<SuccessApiResult<ProfileUserModel>>());

    final data = (result as SuccessApiResult).data;
    expect(data.firstName, "Rahma");
    expect(data.email, "rahma@test.com");

    verify(mockRemote.getProfile(token)).called(1);
  });

  test('returns ErrorApiResult when remote fails', () async {
    const token = "Bearer token";

    when(
      mockRemote.getProfile(token),
    ).thenAnswer((_) async => ErrorApiResult(error: "401"));

    final result = await repo.getCurrentUser(token);

    expect(result, isA<ErrorApiResult<ProfileUserModel>>());
  });
}
