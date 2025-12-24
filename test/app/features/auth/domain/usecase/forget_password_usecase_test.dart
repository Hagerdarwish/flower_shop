import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower_shop/app/features/auth/domain/repos/auth_repo.dart';
import 'package:flower_shop/app/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_usecase_test.mocks.dart';
@GenerateMocks([AuthRepo])
void main() {
  late ForgotPasswordUseCase useCase;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    useCase = ForgotPasswordUseCase(mockAuthRepo);
  });

  group('ForgotPasswordUseCase', () {
    test('should call repo.forgotPassword with correct email', () async {
      // Arrange
      const email = 'amarium363@example.com';
      final repoResult = SuccessApiResult(
        data: ForgotPasswordEntity(
          message: 'success',
          info: 'OTP sent',
        ),
      );

      when(mockAuthRepo.forgotPassword(email))
          .thenAnswer((_) async => repoResult);

      // Act
      await useCase(email);

      // Assert
      verify(mockAuthRepo.forgotPassword(email)).called(1);
    });

    test('should return SuccessApiResult from repo', () async {
      // Arrange
      const email = 'amarium363@example.com';
      final repoResult = SuccessApiResult(
        data: ForgotPasswordEntity(
          message: 'success',
          info: 'OTP sent',
        ),
      );

      when(mockAuthRepo.forgotPassword(email))
          .thenAnswer((_) async => repoResult);

      // Act
      final result = await useCase(email);

      // Assert
      expect(result, equals(repoResult));
    });

    test('should return ErrorApiResult from repo', () async {
      // Arrange
      const email = 'nonexistent@example.com';
      final repoResult = ErrorApiResult<ForgotPasswordEntity>(
        error: 'No account found',
      );

      when(mockAuthRepo.forgotPassword(email))
          .thenAnswer((_) async => repoResult);

      // Act
      final result = await useCase(email);

      // Assert
      expect(result, equals(repoResult));
    });
  });
}