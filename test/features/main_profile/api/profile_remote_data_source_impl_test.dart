import 'package:dio/dio.dart';
import 'package:flower_shop/features/main_profile/api/profile_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

import '../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';
import 'profile_remote_data_source_impl_test.mocks.dart' hide MockApiClient;

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockApiClient);
  });

  group("ProfileRemoteDataSourceImpl.getProfile()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        // arrange
        const token = "Bearer test-token";

        final fakeResponse = ProfileResponse(
          message: "success",
          profileUserModel: ProfileUserModel(
            id: "1",
            firstName: "Rahma",
            lastName: "Ahmed",
            email: "rahma@test.com",
          ),
        );

        final dioResponse = Response<ProfileResponse>(
          requestOptions: RequestOptions(path: '/profile'),
          data: fakeResponse,
          statusCode: 200,
        );

        final fakeHttpResponse = HttpResponse<ProfileResponse>(
          dioResponse.data!,
          dioResponse,
        );

        when(
          mockApiClient.getProfileData(token),
        ).thenAnswer((_) async => fakeHttpResponse);

        // act
        final result = await dataSource.getProfile(token);

        // assert
        expect(result, isA<SuccessApiResult<ProfileResponse>>());

        final data = (result as SuccessApiResult).data;
        expect(data.message, "success");
        expect(data.profileUserModel?.firstName, "Rahma");
        expect(data.profileUserModel?.email, "rahma@test.com");

        verify(mockApiClient.getProfileData(token)).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // arrange
      const token = "Bearer test-token";

      when(
        mockApiClient.getProfileData(token),
      ).thenThrow(Exception("network error"));

      // act
      final result = await dataSource.getProfile(token);

      // assert
      expect(result, isA<ErrorApiResult<ProfileResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );

      verify(mockApiClient.getProfileData(token)).called(1);
    });
  });
}
