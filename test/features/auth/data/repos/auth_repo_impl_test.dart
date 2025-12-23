import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';
import 'package:flower_shop/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late AuthRepoImpl repoImpl;

  setUpAll(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepoImpl(remoteDataSource: mockRemoteDataSource);
    provideDummy<ApiResult<SignupDto>>(
      SuccessApiResult<SignupDto>(data: SignupDto()),
    );
  });

  group("AuthRepoImpl.signUp()", () {
    test('should return ApiSuccess when datasource succeeds', () async {
      final fakeDto = SignupDto(
        message: 'Success',
        token: 'fake_token',
        user: UserDto(
          firstName: 'test',
          lastName: 'test',
          email: 'test@test.com',
          phone: '+20100000000',
          gender: 'female',
        ),
      );

      when(
        mockRemoteDataSource.signUp(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          phone: anyNamed('phone'),
          gender: anyNamed('gender'),
        ),
      ).thenAnswer((_) async => SuccessApiResult<SignupDto>(data: fakeDto));

      final result =
          await repoImpl.signup(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'Mm@123456',
                rePassword: 'Mm@123456',
                phone: '+20100000000',
                gender: 'female',
              )
              as SuccessApiResult<SignupModel>;

      expect(result, isA<SuccessApiResult<SignupModel>>());
      expect(result.data.token, fakeDto.token);
      expect(result.data.user!.email, fakeDto.user!.email);
      verify(
        mockRemoteDataSource.signUp(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          phone: anyNamed('phone'),
          gender: anyNamed('gender'),
        ),
      ).called(1);
    });

    test('should return ApiFailure when datasource throws exception', () async {
      when(
        mockRemoteDataSource.signUp(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          phone: anyNamed('phone'),
          gender: anyNamed('gender'),
        ),
      ).thenAnswer(
        (_) async => ErrorApiResult<SignupDto>(error: 'Network error'),
      );

      final result =
          await repoImpl.signup(
                firstName: 'test',
                lastName: 'test',
                email: 'test@test.com',
                password: 'Mm@123456',
                rePassword: 'Mm@123456',
                phone: '+20100000000',
                gender: 'female',
              )
              as ErrorApiResult<SignupModel>;

      expect(result, isA<ErrorApiResult<SignupModel>>());
      expect(result.error.toString(), contains("Network error"));
      verify(
        mockRemoteDataSource.signUp(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          rePassword: anyNamed('rePassword'),
          phone: anyNamed('phone'),
          gender: anyNamed('gender'),
        ),
      ).called(1);
    });
  });
}
