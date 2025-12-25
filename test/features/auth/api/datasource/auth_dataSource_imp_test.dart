import 'package:dio/dio.dart';
import 'package:flower_shop/features/auth/api/datasourse/auth_dataSource_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:retrofit/dio.dart';
import 'auth_dataSource_imp_test.mocks.dart';


@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AuthDatasourceImp datasource;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = AuthDatasourceImp(mockApiClient);
  });

  final loginRequest = LoginRequest(email: "test@test.com", password: "123456");

  group("AuthDatasourceImp.login()", () {
    test("returns SuccessApiResult when apiClient returns valid response", () async {
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
      final fakeHttpResponse = HttpResponse<LoginResponse>(dioResponse.data!, dioResponse);
      when(mockApiClient.login(any)).thenAnswer((_) async => fakeHttpResponse);

      // ACT
      final result = await datasource.login(loginRequest);

      // ASSERT
      expect(result, isA<SuccessApiResult<LoginResponse>>());
      final data = (result as SuccessApiResult).data;
      expect(data.message, "success");
      expect(data.token, "abc123");
      verify(mockApiClient.login(any)).called(1);
    });

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // ARRANGE
      when(mockApiClient.login(any)).thenThrow(Exception("network error"));

      // ACT
      final result = await datasource.login(loginRequest);

      // ASSERT
      expect(result, isA<ErrorApiResult<LoginResponse>>());
      expect((result as ErrorApiResult).error.toString(), contains("network error"));
      verify(mockApiClient.login(any)).called(1);
    });
  });
}
