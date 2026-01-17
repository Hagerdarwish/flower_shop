import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/data/models/response/user_model.dart';
import 'package:flower_shop/features/auth/data/repos/auth_repo_imp.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late MockAuthRemoteDataSource mockDataSource;
  late AuthRepoImp repo;

  setUpAll(() {
    mockDataSource = MockAuthRemoteDataSource();
    repo = AuthRepoImp(mockDataSource);
    provideDummy<ApiResult<SignupDto>>(
      SuccessApiResult<SignupDto>(data: SignupDto()),
    );
  });

  final email = "test@test.com";
  final password = "123456";

  group("AuthRepoImp.login()", () {
    test(
      "returns SuccessApiResult when datasource returns valid response",
      () async {
        // ARRANGE
        final fakeResponse = LoginResponse(
          message: "success",
          token: "abc123",
          user: User(
            Id: "1",
            firstName: "Nouran",
            lastName: "Samer",
            email: "test@test.com",
            role: "student",
            wishlist: [],
          ),
        );
        when(mockDataSource.login(any)).thenAnswer(
          (_) async => SuccessApiResult<LoginResponse>(data: fakeResponse),
        );

        // ACT
        final result = await repo.login(email, password);
        // ASSERT
        expect(result, isA<SuccessApiResult<LoginModel>>());
        final data = (result as SuccessApiResult).data;
        expect(data.message, "success");
        expect(data.token, "abc123");
        expect(data.user.firstName, "Nouran");
        verify(mockDataSource.login(any)).called(1);
      },
    );

    test(
      "returns ErrorApiResult when datasource returns ErrorApiResult",
      () async {
        // ARRANGE
        when(mockDataSource.login(any)).thenAnswer(
          (_) async => ErrorApiResult<LoginResponse>(error: "network error"),
        );
        // ACT
        final result = await repo.login(email, password);
        // ASSERT
        expect(result, isA<ErrorApiResult<LoginModel>>());
        expect((result as ErrorApiResult).error, "network error");
        verify(mockDataSource.login(any)).called(1);
      },
    );

    test(
      "returns ErrorApiResult with Unknown error when datasource returns unexpected result",
      () async {
        // ARRANGE
        when(mockDataSource.login(any)).thenAnswer((_) async => null);
        // ACT
        final result = await repo.login(email, password);
        // ASSERT
        expect(result, isA<ErrorApiResult<LoginModel>>());
        expect((result as ErrorApiResult).error, "Unknown error");
        verify(mockDataSource.login(any)).called(1);
      },
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
        mockDataSource.signUp(
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
          await repo.signup(
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
        mockDataSource.signUp(
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
        mockDataSource.signUp(
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
          await repo.signup(
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
        mockDataSource.signUp(
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
