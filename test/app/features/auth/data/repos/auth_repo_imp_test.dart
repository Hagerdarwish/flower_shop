import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/data/datasoure/auth_datasource.dart';
import 'package:flower_shop/app/features/auth/data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';
import 'package:flower_shop/app/features/auth/data/repos/auth_repo_imp.dart';
import 'package:flower_shop/app/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_imp_test.mocks.dart';

@GenerateMocks([AuthDatasource])
void main() {
  late AuthRepoImp authRepo;
  late MockAuthDatasource mockAuthDatasource;

  setUp(() {
    mockAuthDatasource = MockAuthDatasource();
    authRepo = AuthRepoImp(mockAuthDatasource);
  });

  group('AuthRepoImp.verifyResetCode', () {
    test('should return SuccessApiResult with entity when verification succeeds', () async {
      // Arrange
      const code = '123456';
      final datasourceResult = SuccessApiResult(
        data: VerifyResetCodeResponse(status: 'valid'),
      );

      when(mockAuthDatasource.verifyResetCode(any))
          .thenAnswer((_) async => datasourceResult);

      // Act
      final result = await authRepo.verifyResetCode(code);

      // Assert
      expect(result, isA<SuccessApiResult<VerifyResetCodeEntity>>());
      expect((result as SuccessApiResult).data.status, 'valid');
    });

    test('should return ErrorApiResult when datasource returns invalid code error', () async {
      // Arrange
      const code = 'wrong123';
      final datasourceResult = ErrorApiResult<VerifyResetCodeResponse>(
        error: 'Invalid verification code',
      );

      when(mockAuthDatasource.verifyResetCode(any))
          .thenAnswer((_) async => datasourceResult);

      // Act
      final result = await authRepo.verifyResetCode(code);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeEntity>>());
      expect((result as ErrorApiResult).error, 'Invalid verification code');
    });

    test('should return ErrorApiResult when datasource returns expired code error', () async {
      // Arrange
      const code = 'expired';
      final datasourceResult = ErrorApiResult<VerifyResetCodeResponse>(
        error: 'Verification code has expired',
      );

      when(mockAuthDatasource.verifyResetCode(any))
          .thenAnswer((_) async => datasourceResult);

      // Act
      final result = await authRepo.verifyResetCode(code);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeEntity>>());
      expect((result as ErrorApiResult).error, 'Verification code has expired');
    });

    test('should return ErrorApiResult for unexpected result type', () async {
      // Arrange
      const code = '123456';

      // Mock to return null (unexpected)
      when(mockAuthDatasource.verifyResetCode(any))
          .thenAnswer((_) async => null);

      // Act
      final result = await authRepo.verifyResetCode(code);

      // Assert
      expect(result, isA<ErrorApiResult<VerifyResetCodeEntity>>());
      expect((result as ErrorApiResult).error, 'Unexpected error');
    });
  });
}