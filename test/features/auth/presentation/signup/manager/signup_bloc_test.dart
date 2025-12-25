import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_cubit.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_intent.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'signup_bloc_test.mocks.dart';

@GenerateMocks([SignupUsecase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSignupUsecase mockUseCase;
  late AuthCubit cubit;

  setUpAll(() {
    mockUseCase = MockSignupUsecase();
    provideDummy<ApiResult<SignupModel>>(SuccessApiResult(data: SignupModel()));
  });
  setUp(() {
    cubit = AuthCubit(mockUseCase);
  });
  tearDown(() async {
    await cubit.close();
  });
  group("Signup Event", () {
    blocTest<AuthCubit, AuthStates>(
      'emits loading then success when usecase returns SuccessApiResult',
      build: () {
        final fakeData = SignupModel(
          message: 'Success',
          token: 'fake_token',
          user: UserModel(
            firstName: 'test',
            lastName: 'test',
            email: 'test@test.com',
            phone: '+20100000000',
            gender: 'female',
          ),
        );

        when(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            rePassword: anyNamed('rePassword'),
            phone: anyNamed('phone'),
            gender: anyNamed('gender'),
          ),
        ).thenAnswer(
          (_) async => SuccessApiResult<SignupModel>(data: fakeData),
        );
        return cubit;
      },

      act: (cubit) {
        cubit.doIntent(FirstNameChangedEvent(firstName: 'test'));
        cubit.doIntent(LastNameChangedEvent(lastName: 'test'));
        cubit.doIntent(EmailChangedEvent(email: 'test@test.com'));
        cubit.doIntent(PasswordChangedEvent(password: 'password'));
        cubit.doIntent(
          ConfirmPasswordChangedEvent(confirmPassword: 'password'),
        );
        cubit.doIntent(PhoneChangedEvent(phone: '+20100000000'));
        cubit.doIntent(GenderChangedEvent(gender: 'female'));
        return cubit.doIntent(SignupEvent());
      },
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeFirstName,
          "changeFirstName",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeLastName,
          "changeLastName",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeEmail,
          "changeEmail",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changePassword,
          "changePassword",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeConfirmPassword,
          "changeConfirmPassword",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changePhone,
          "changePhone",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeGender,
          "changeGender",
          true,
        ),

        isA<AuthStates>().having(
          (s) => s.signupState!.status,
          "status",
          Status.loading,
        ),
        isA<AuthStates>()
            .having((s) => s.signupState!.status, "status", Status.success)
            .having((s) => s.signupState!.data!.token, "token", "fake_token")
            .having(
              (s) => s.signupState!.data!.user!.firstName,
              "firstName",
              "test",
            ),
      ],
      verify: (_) {
        verify(
          mockUseCase.call(
            firstName: 'test',
            lastName: 'test',
            email: 'test@test.com',
            password: 'password',
            rePassword: 'password',
            phone: '+20100000000',
            gender: 'female',
          ),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits loading then error when usecase returns ErrorApiResult',
      build: () {
        when(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            password: anyNamed('password'),
            rePassword: anyNamed('rePassword'),
            phone: anyNamed('phone'),
            gender: anyNamed('gender'),
          ),
        ).thenAnswer(
          (_) async => ErrorApiResult<SignupModel>(error: 'Signup failed'),
        );
        return cubit;
      },

      act: (cubit) {
        cubit.doIntent(FirstNameChangedEvent(firstName: 'test'));
        cubit.doIntent(LastNameChangedEvent(lastName: 'test'));
        cubit.doIntent(EmailChangedEvent(email: 'test@test.com'));
        cubit.doIntent(PasswordChangedEvent(password: 'password'));
        cubit.doIntent(
          ConfirmPasswordChangedEvent(confirmPassword: 'password'),
        );
        cubit.doIntent(PhoneChangedEvent(phone: '+20100000000'));
        cubit.doIntent(GenderChangedEvent(gender: 'female'));
        return cubit.doIntent(SignupEvent());
      },
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeFirstName,
          "changeFirstName",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeLastName,
          "changeLastName",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeEmail,
          "changeEmail",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changePassword,
          "changePassword",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeConfirmPassword,
          "changeConfirmPassword",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changePhone,
          "changePhone",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.changeGender,
          "changeGender",
          true,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.status,
          'status',
          Status.loading,
        ),
        isA<AuthStates>().having(
          (s) => s.signupState!.error,
          'error',
          contains('Signup failed'),
        ),
      ],

      verify: (_) {
        verify(
          mockUseCase.call(
            firstName: 'test',
            lastName: 'test',
            email: 'test@test.com',
            password: 'password',
            rePassword: 'password',
            phone: '+20100000000',
            gender: 'female',
          ),
        ).called(1);
      },
    );
  });

  group('AuthCubit field changes', () {
    blocTest<AuthCubit, AuthStates>(
      'emits state with changeFirstName=true',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(FirstNameChangedEvent(firstName: 'test')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeFirstName,
          'changeFirstName',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.fName, 'test');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changeLastName=true',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(LastNameChangedEvent(lastName: 'test2')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeLastName,
          'changeLastName',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.lName, 'test2');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changeEmail=true',
      build: () => cubit,
      act: (cubit) =>
          cubit.doIntent(EmailChangedEvent(email: 'test@example.com')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeEmail,
          'changeEmail',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.email, 'test@example.com');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changePassword=true',
      build: () => cubit,
      act: (cubit) =>
          cubit.doIntent(PasswordChangedEvent(password: 'password')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changePassword,
          'changePassword',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.password, 'password');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changeConfirmPassword=true',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        ConfirmPasswordChangedEvent(confirmPassword: 'password'),
      ),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeConfirmPassword,
          'changeConfirmPassword',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.confirmPassword, 'password');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changePhone=true',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(PhoneChangedEvent(phone: '+20100000000')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changePhone,
          'changePhone',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.phone, '+20100000000');
      },
    );

    blocTest<AuthCubit, AuthStates>(
      'emits state with changeGender=true',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(GenderChangedEvent(gender: 'female')),
      expect: () => [
        isA<AuthStates>().having(
          (s) => s.signupState!.changeGender,
          'changeGender',
          true,
        ),
      ],
      verify: (_) {
        expect(cubit.gender, 'female');
      },
    );
  });
}
