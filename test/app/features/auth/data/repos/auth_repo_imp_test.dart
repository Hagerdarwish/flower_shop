import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/data/datasoure/auth_datasource.dart';
import 'package:flower_shop/app/features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import 'package:flower_shop/app/features/auth/data/repos/auth_repo_imp.dart';
import 'package:flower_shop/app/features/auth/domain/models/forget_password_entity.dart';
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

  group('AuthRepoImp.forgotPassword', () {
    test('should return SuccessApiResult with entity when datasource succeeds', () async {
      // Arrange
      const email = 'amarium363@example.com';
      final datasourceResult = SuccessApiResult(
        data: ForgotPasswordResponse(
          message: 'success',
          info: 'OTP sent to your email',
        ),
      );

      when(mockAuthDatasource.forgotPassword(any))
          .thenAnswer((_) async => datasourceResult);

      // Act
      final result = await authRepo.forgotPassword(email);

      // Assert
      expect(result, isA<SuccessApiResult<ForgotPasswordEntity>>());
      expect((result as SuccessApiResult).data.message, 'success');
      expect((result as SuccessApiResult).data.info, 'OTP sent to your email');
    });

    test('should return ErrorApiResult when datasource returns error', () async {
      // Arrange
      const email = 'nonexistent@example.com';
      final datasourceResult = ErrorApiResult<ForgotPasswordResponse>(
        error: 'There is no account with this email address',
      );

      when(mockAuthDatasource.forgotPassword(any))
          .thenAnswer((_) async => datasourceResult);

      // Act
      final result = await authRepo.forgotPassword(email);

      // Assert
      expect(result, isA<ErrorApiResult<ForgotPasswordEntity>>());
      expect((result as ErrorApiResult).error, 'There is no account with this email address');
    });

    test('should return ErrorApiResult for unexpected result type', () async {
      // Arrange
      const email = 'test@example.com';

      when(mockAuthDatasource.forgotPassword(any))
          .thenAnswer((_) async => null);

      // Act
      final result = await authRepo.forgotPassword(email);

      // Assert
      expect(result, isA<ErrorApiResult<ForgotPasswordEntity>>());
      expect((result as ErrorApiResult).error, 'Unexpected error');
    });
  });
}