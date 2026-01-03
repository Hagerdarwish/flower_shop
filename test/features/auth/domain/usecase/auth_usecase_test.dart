import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:flower_shop/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockRepo;
  late SignupUsecase useCase;

  setUpAll(() {
    mockRepo = MockAuthRepo();
    useCase = SignupUsecase(mockRepo);
    provideDummy<ApiResult<SignupModel>>(
      SuccessApiResult<SignupModel>(data: SignupModel()),
    );
  });

  group("RegisterUseCase", () {
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
    test("returns SuccessApiResult when repos returns success", () async {
      when(
        mockRepo.signup(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          phone: anyNamed('phone'),
          gender: anyNamed('gender'),
        ),
      ).thenAnswer((_) async => SuccessApiResult<SignupModel>(data: fakeData));

      final result =
          await useCase.call(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'password',
                rePassword: 'password',
                phone: '+20100000000',
                gender: 'female',
              )
              as SuccessApiResult<SignupModel>;

      expect(result, isA<SuccessApiResult<SignupModel>>());
      final data = (result as SuccessApiResult).data;
      expect(data.token, fakeData.token);
      expect(data.user.firstName, fakeData.user!.firstName);
      verify(
        mockRepo.signup(
          firstName: 'test',
          lastName: 'test',
          email: 'test@test.com',
          password: 'password',
          rePassword: 'password',
          phone: '+20100000000',
          gender: 'female',
        ),
      ).called(1);
    });

    test("returns ErrorApiResult when repos returns error", () async {
      when(
        mockRepo.signup(
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

      final result =
          await useCase.call(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'password',
                rePassword: 'password',
                phone: '+20100000000',
                gender: 'female',
              )
              as ErrorApiResult<SignupModel>;

      expect(result, isA<ErrorApiResult<SignupModel>>());
      final error = (result as ErrorApiResult).error;
      expect(error, 'Signup failed');
      verify(
        mockRepo.signup(
          firstName: 'test',
          lastName: 'test',
          email: 'test@test.com',
          password: 'password',
          rePassword: 'password',
          phone: '+20100000000',
          gender: 'female',
        ),
      ).called(1);
    });
  });
}
