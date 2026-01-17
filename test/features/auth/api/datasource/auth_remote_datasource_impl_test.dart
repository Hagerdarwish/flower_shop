import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/api/datasource/auth_remote_datasource_impl.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockApiClient);
  });

  final loginRequest = LoginRequest(email: "test@test.com", password: "123456");

  group("AuthDatasourceImp.login()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        // ARRANGE
        final fakeResponse = LoginResponse(
          message: "success",
          token: "abc123",
          user: null,
        );
        final dioResponse = Response<LoginResponse>(
          requestOptions: RequestOptions(path: '/login'),
          data: fakeResponse,
          statusCode: 200,
        );
        final fakeHttpResponse = HttpResponse<LoginResponse>(
          dioResponse.data!,
          dioResponse,
        );
        when(
          mockApiClient.login(any),
        ).thenAnswer((_) async => fakeHttpResponse);

        // ACT
        final result = await dataSource.login(loginRequest);

        // ASSERT
        expect(result, isA<SuccessApiResult<LoginResponse>>());
        final data = (result as SuccessApiResult).data;
        expect(data.message, "success");
        expect(data.token, "abc123");
        verify(mockApiClient.login(any)).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // ARRANGE
      when(mockApiClient.login(any)).thenThrow(Exception("network error"));

      // ACT
      final result = await dataSource.login(loginRequest);

      // ASSERT
      expect(result, isA<ErrorApiResult<LoginResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );
      verify(mockApiClient.login(any)).called(1);
    });
  });

  group("AuthRemoteDataSourceImpl.signUp()", () {
    test('should return ApiSuccess when signup succeeds', () async {
      final fakeDto = SignupDto(
        message: 'Success',
        token: 'fake_token',
        user: UserDto(
          firstName: 'test',
          lastName: 'test',
          email: 'test@test.com',
        ),
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/auth/signup'),
          statusCode: 200,
        ),
      );
      when(mockApiClient.signUp(any)).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.signUp(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'Mm@123456',
                rePassword: 'Mm@123456',
                phone: '+20100000000',
                gender: 'female',
              )
              as SuccessApiResult<SignupDto>;

      expect(result, isA<SuccessApiResult<SignupDto>>());
      expect(result.data.token, fakeDto.token);
      expect(result.data.user!.email, fakeDto.user!.email);
      verify(mockApiClient.signUp(any)).called(1);
    });

    test('should return ApiFailure when signup throws exception', () async {
      when(mockApiClient.signUp(any)).thenThrow(Exception('Network error'));

      final result =
          await dataSource.signUp(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'Mm@123456',
                rePassword: 'Mm@123456',
                phone: '+20100000000',
                gender: 'female',
              )
              as ErrorApiResult<SignupDto>;

      expect(result, isA<ErrorApiResult<SignupDto>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.signUp(any)).called(1);
    });
  });
}
