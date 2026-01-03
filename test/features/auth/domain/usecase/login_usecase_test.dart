import 'package:flower_shop/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockRepo;
  late LoginUseCase useCase;

  setUp(() {
    mockRepo = MockAuthRepo();
    useCase = LoginUseCase(mockRepo);
  });

  final email = "test@test.com";
  final password = "123456";

  final loginModel = LoginModel(
    message: "success",
    token: "abc123",
    user: UserModel(
      id: "1",
      firstName: "Nouran",
      lastName: "Samer",
      email: "test@test.com",
      photo: null,
      role: "student",
      wishlist: [],
    ),
  );

  group("LoginUseCase", () {
    test("returns SuccessApiResult when repos returns success", () async {
      // ARRANGE
      provideDummy<ApiResult<LoginModel>>(SuccessApiResult(data: loginModel));
      when(mockRepo.login(email, password))
          .thenAnswer((_) async => SuccessApiResult<LoginModel>(data: loginModel));

      // ACT
      final result = await useCase.call(email, password);

      // ASSERT
      expect(result, isA<SuccessApiResult<LoginModel>>());
      final data = (result as SuccessApiResult).data;
      expect(data.token, equals("abc123"));
      expect(data.user.firstName, equals("Nouran"));
      verify(mockRepo.login(email, password)).called(1);
    });

    test("returns ErrorApiResult when repos returns error", () async {
      // ARRANGE
      provideDummy<ApiResult<LoginModel>>(ErrorApiResult(error: "login failed"));
      final error = Exception("login failed");
      when(mockRepo.login(email, password))
          .thenAnswer((_) async => ErrorApiResult<LoginModel>(error: error.toString()));

      // ACT
      final result = await useCase.call(email, password);

      // ASSERT
      expect(result, isA<ErrorApiResult<LoginModel>>());
      expect((result as ErrorApiResult).error.toString(), contains("login failed"));
      verify(mockRepo.login(email, password)).called(1);
    });
  });
}
