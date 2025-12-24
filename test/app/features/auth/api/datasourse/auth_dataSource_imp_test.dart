import 'package:dio/dio.dart';
import 'package:flower_shop/app/features/auth/data/models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/api/datasourse/auth_dataSource_imp.dart';
import 'package:flower_shop/app/features/auth/data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_dataSource_imp_test.mocks.dart';
@GenerateMocks([ApiClient])
void main() {
  late AuthDatasourceImp authDatasource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    authDatasource = AuthDatasourceImp(mockApiClient);
  });

  group('AuthDatasourceImp.verifyResetCode', () {
    test('should return SuccessApiResult when verification succeeds', () async {
      // Arrange
      final request = VerifyResetCodeRequest(resetCode: '123456');
      final responseData = VerifyResetCodeResponse(status: 'valid');

      final dioResponse = Response<VerifyResetCodeResponse>(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/verify-reset-code'),
      );

      final httpResponse = HttpResponse<VerifyResetCodeResponse>(
        responseData,
        dioResponse,
      );

      when(mockApiClient.verifyResetCode(request))
          .thenAnswer((_) async => httpResponse);

      // Act
      final result = await authDatasource.verifyResetCode(request);

      // Assert
      expect(result, isA<SuccessApiResult<VerifyResetCodeResponse>>());
      expect((result as SuccessApiResult).data.status, 'valid');
    });

    test('should return ErrorApiResult when code is invalid', () async {
      // Arrange
      final request = VerifyResetCodeRequest(resetCode: 'wrong123');
      final errorResponse = {'error': 'Invalid verification code'};

      final dioResponse = Response<dynamic>(
        data: errorResponse,
        statusCode: 400,
        requestOptions: RequestOptions(path: '/verify-reset-code'),
      );

      final httpResponse = HttpResponse<dynamic>(
        errorResponse,
        dioResponse,
      );

      when(mockApiClient.verifyResetCode(request))
          .thenAnswer((_) async => httpResponse);

      // Act
      final result = await authDatasource.verifyResetCode(request);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeResponse>>());
      expect((result as ErrorApiResult).error, contains('Invalid verification code'));
    });

    test('should return ErrorApiResult when code is expired', () async {
      // Arrange
      final request = VerifyResetCodeRequest(resetCode: 'expired');
      final errorResponse = {'error': 'Verification code has expired'};

      final dioResponse = Response<dynamic>(
        data: errorResponse,
        statusCode: 410, // Gone
        requestOptions: RequestOptions(path: '/verify-reset-code'),
      );

      final httpResponse = HttpResponse<dynamic>(
        errorResponse,
        dioResponse,
      );

      when(mockApiClient.verifyResetCode(request))
          .thenAnswer((_) async => httpResponse);

      // Act
      final result = await authDatasource.verifyResetCode(request);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeResponse>>());
      expect((result as ErrorApiResult).error, contains('expired'));
    });

    test('should return ErrorApiResult on network failure', () async {
      // Arrange
      final request = VerifyResetCodeRequest(resetCode: '123456');

      when(mockApiClient.verifyResetCode(request))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/verify-reset-code')));

      // Act
      final result = await authDatasource.verifyResetCode(request);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeResponse>>());
      expect((result as ErrorApiResult).error, isNotEmpty);
    });
  });
}