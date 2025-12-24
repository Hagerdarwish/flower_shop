import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower_shop/app/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:flower_shop/app/features/auth/presentation/forget_password/manager/forget_password_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgotPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgotPasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockForgotPasswordUseCase();
    cubit = ForgetPasswordCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit', () {
    test('initial state should be ForgetPasswordState.initial()', () {
      // Assert
      expect(cubit.state, equals(ForgetPasswordState.initial()));
      expect(cubit.state.resource.status, equals(Status.initial));
      expect(cubit.state.isFormValid, isFalse);
    });

    group('_validateForm', () {
      test('should emit isFormValid = true when email is filled', () {
        // Arrange
        cubit.emailController.text = 'test@example.com';

        // Act
        cubit.doIntent(const FormChangedIntent());

        // Assert
        expect(cubit.state.isFormValid, isTrue);
      });

      test('should emit isFormValid = false when email is empty', () {
        // Arrange
        cubit.emailController.text = '';

        // Act
        cubit.doIntent(const FormChangedIntent());

        // Assert
        expect(cubit.state.isFormValid, isFalse);
      });
    });

    group('_submitForgetPassword', () {
      test('should emit loading then success when useCase returns success message', () async {
        // Arrange
        cubit.emailController.text = 'amarium363@example.com';
        final successEntity = ForgotPasswordEntity(
          message: 'success',
          info: 'OTP sent',
        );

        when(mockUseCase(any))
            .thenAnswer((_) async => SuccessApiResult(data: successEntity));

        // Act & Assert
        expectLater(
          cubit.stream,
          emitsInOrder([
            ForgetPasswordState.initial(), // Initial state
            ForgetPasswordState.initial().copyWith(
              resource: Resource.loading(),
            ),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.success(successEntity),
            ),
          ]),
        );

        // Trigger
        cubit.doIntent(const SubmitForgetPasswordIntent());
      });

      test('should emit loading then error when useCase returns error', () async {
        // Arrange
        cubit.emailController.text = 'nonexistent@example.com';

        when(mockUseCase(any))
            .thenAnswer((_) async => ErrorApiResult(error: 'No account found'));

        // Act & Assert
        expectLater(
          cubit.stream,
          emitsInOrder([
            ForgetPasswordState.initial(),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.loading(),
            ),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.error('No account found'),
            ),
          ]),
        );

        // Trigger
        cubit.doIntent(const SubmitForgetPasswordIntent());
      });

      test('should emit error when success response does not contain "success" in message', () async {
        // Arrange
        cubit.emailController.text = 'test@example.com';
        final entityWithError = ForgotPasswordEntity(
          message: 'There is no account with this email address',
          info: 'Error info',
        );

        when(mockUseCase(any))
            .thenAnswer((_) async => SuccessApiResult(data: entityWithError));

        // Act & Assert
        expectLater(
          cubit.stream,
          emitsInOrder([
            ForgetPasswordState.initial(),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.loading(),
            ),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.error('There is no account with this email address'),
            ),
          ]),
        );

        // Trigger
        cubit.doIntent(const SubmitForgetPasswordIntent());
      });

      test('should not call useCase when form is invalid', () async {
        // Arrange
        cubit.emailController.text = 'invalid-email';

        // Act
        cubit.doIntent(const SubmitForgetPasswordIntent());

        // Assert
        verifyNever(mockUseCase(any));
      });

      test('should handle unexpected error from useCase', () async {
        // Arrange
        cubit.emailController.text = 'test@example.com';

        when(mockUseCase(any))
            .thenThrow(Exception('Unexpected'));

        // Act & Assert
        expectLater(
          cubit.stream,
          emitsInOrder([
            ForgetPasswordState.initial(),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.loading(),
            ),
            ForgetPasswordState.initial().copyWith(
              resource: Resource.error('Unexpected error'),
            ),
          ]),
        );

        // Trigger
        cubit.doIntent(const SubmitForgetPasswordIntent());
      });
    });

    group('Form validation', () {
      test('should update isFormValid when email changes', () {
        // Act & Assert
        cubit.emailController.text = 'amarium363@example.com';
        cubit.doIntent(const FormChangedIntent());
        expect(cubit.state.isFormValid, isTrue);

        cubit.emailController.text = '';
        cubit.doIntent(const FormChangedIntent());
        expect(cubit.state.isFormValid, isFalse);
      });
    });
  });
}