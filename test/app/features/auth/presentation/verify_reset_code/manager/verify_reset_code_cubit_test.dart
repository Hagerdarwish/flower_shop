import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower_shop/app/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:flower_shop/app/features/auth/domain/usecase/verify_reset_code_usecase.dart';
import 'package:flower_shop/app/features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart';
import 'package:flower_shop/app/features/auth/presentation/verify_reset_code/manager/verify_reset_code_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

import 'verify_reset_code_cubit_test.mocks.dart';

@GenerateMocks([VerifyResetCodeUseCase, ForgotPasswordUseCase])
void main() {
  late VerifyResetCodeCubit cubit;
  late MockVerifyResetCodeUseCase mockVerifyUseCase;
  late MockForgotPasswordUseCase mockResendUseCase;

  const testEmail = 'test@example.com';

  setUp(() {
    mockVerifyUseCase = MockVerifyResetCodeUseCase();
    mockResendUseCase = MockForgotPasswordUseCase();
    cubit = VerifyResetCodeCubit(mockVerifyUseCase, mockResendUseCase, testEmail);
  });

  tearDown(() {
    cubit.close();
  });

  group('VerifyResetCodeCubit', () {
    test('initial state should be VerifyResetCodeState.initial()', () {
      expect(cubit.state, VerifyResetCodeState.initial());
      expect(cubit.state.resource.status, Status.initial);
      expect(cubit.state.isFormValid, isFalse);
      expect(cubit.state.code, isEmpty);
    });

    group('_validateForm', () {
      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should update code and set isFormValid=true for 6-digit code',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(const FormChangedIntent('123456')),
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            code: '123456',
            isFormValid: true,
          ),
        ],
      );

      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should update code and set isFormValid=false for 5-digit code',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(const FormChangedIntent('12345')),
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            code: '12345',
            isFormValid: false,
          ),
        ],
      );

      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should update code and set isFormValid=true for 6-digit code after invalid',
        build: () => cubit,
        act: (cubit) async {
          cubit.doIntent(const FormChangedIntent('123'));
          cubit.doIntent(const FormChangedIntent('123456'));
        },
        skip: 1,
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            code: '123456',
            isFormValid: true,
          ),
        ],
      );
    });

    group('_submitCode', () {
      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should not call useCase when form is invalid',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(const SubmitVerifyCodeIntent()),
        setUp: () {
          // Form is invalid initially
        },
        verify: (_) {
          verifyNever(mockVerifyUseCase(any));
        },
      );

      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should emit [loading, success] when code verification succeeds',
        build: () => cubit,
        act: (cubit) async {
          cubit.doIntent(const FormChangedIntent('123456'));
           cubit.doIntent(const SubmitVerifyCodeIntent());
        },
        setUp: () {
          when(mockVerifyUseCase('123456')).thenAnswer(
                (_) async => SuccessApiResult(
              data: VerifyResetCodeEntity(status: 'valid'),
            ),
          );
        },
        skip: 1,
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            code: '123456',
            isFormValid: true,
            resource: Resource.loading(),
          ),
          VerifyResetCodeState.initial().copyWith(
            code: '123456',
            isFormValid: true,
            resource: Resource.success(VerifyResetCodeEntity(status: 'valid')),
          ),
        ],
      );

      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should emit [loading, error] when code is invalid',
        build: () => cubit,
        act: (cubit) async {
          cubit.doIntent(const FormChangedIntent('wrong'));
           cubit.doIntent(const SubmitVerifyCodeIntent());
        },
        setUp: () {
          when(mockVerifyUseCase('wrong')).thenAnswer(
                (_) async => ErrorApiResult(error: 'Invalid verification code'),
          );
        },
        skip: 1,
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            code: 'wrong',
            isFormValid: false,
            resource: Resource.loading(),
          ),
          VerifyResetCodeState.initial().copyWith(
            code: 'wrong',
            isFormValid: false,
            resource: Resource.error('Invalid verification code'),
          ),
        ],
      );
    });

    group('_resendCode', () {
      blocTest<VerifyResetCodeCubit, VerifyResetCodeState>(
        'should emit [loading, success] when resend succeeds',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(const ResendCodeIntent()),
        setUp: () {
          when(mockResendUseCase(testEmail)).thenAnswer(
                (_) async => SuccessApiResult(
              data: ForgotPasswordEntity(
                message: 'success',
                info: 'New code sent',
              ),
            ),
          );
        },
        expect: () => [
          VerifyResetCodeState.initial().copyWith(
            resource: Resource.loading(),
          ),
          VerifyResetCodeState.initial().copyWith(
            resource: Resource.success(ForgotPasswordEntity(
              message: 'success',
              info: 'New code sent',
            )),
          ),
        ],
      );
    });

    group('Intent handling', () {
      test('should handle FormChangedIntent', () {
        cubit.doIntent(const FormChangedIntent('123456'));
        expect(cubit.state.code, '123456');
        expect(cubit.state.isFormValid, isTrue);
      });

      test('should handle SubmitVerifyCodeIntent', () async {
        when(mockVerifyUseCase('')).thenAnswer(
              (_) async => SuccessApiResult(
            data: VerifyResetCodeEntity(status: 'valid'),
          ),
        );

        cubit.doIntent(const SubmitVerifyCodeIntent());
        verifyNever(mockVerifyUseCase(any));
      });

      test('should handle ResendCodeIntent', () async {
        when(mockResendUseCase(testEmail)).thenAnswer(
              (_) async => SuccessApiResult(
            data: ForgotPasswordEntity(
              message: 'success',
              info: 'New code sent',
            ),
          ),
        );

         cubit.doIntent(const ResendCodeIntent());
        verify(mockResendUseCase(testEmail)).called(1);
      });
    });
  });
}