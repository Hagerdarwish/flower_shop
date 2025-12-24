
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flower_shop/app/features/auth/domain/repos/auth_repo.dart';
import 'package:flower_shop/app/features/auth/domain/usecase/verify_reset_code_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_reset_code_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late VerifyResetCodeUseCase useCase;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    useCase = VerifyResetCodeUseCase(mockAuthRepo);
  });

  group('VerifyResetCodeUseCase', () {
    test('should call repo.verifyResetCode with correct code', () async {
      // Arrange
      const code = '123456';
      final repoResult = SuccessApiResult(
        data: VerifyResetCodeEntity(status: 'valid'),
      );

      when(mockAuthRepo.verifyResetCode(code))
          .thenAnswer((_) async => repoResult);

      // Act
      await useCase(code);

      // Assert
      verify(mockAuthRepo.verifyResetCode(code)).called(1);
    });

    test('should return SuccessApiResult from repo for valid code', () async {
      // Arrange
      const code = '123456';
      final repoResult = SuccessApiResult(
        data: VerifyResetCodeEntity(status: 'valid'),
      );

      when(mockAuthRepo.verifyResetCode(code))
          .thenAnswer((_) async => repoResult);

      // Act
      final result = await useCase(code);

      // Assert
      expect(result, equals(repoResult));
      expect((result as SuccessApiResult).data.status, 'valid');
    });

    test('should return ErrorApiResult from repo for invalid code', () async {
      // Arrange
      const code = 'wrong123';
      final repoResult = ErrorApiResult<VerifyResetCodeEntity>(
        error: 'Invalid verification code',
      );

      when(mockAuthRepo.verifyResetCode(code))
          .thenAnswer((_) async => repoResult);

      // Act
      final result = await useCase(code);

      // Assert
      expect(result, equals(repoResult));
      expect((result as ErrorApiResult).error, 'Invalid verification code');
    });
  });
}