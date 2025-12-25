import 'package:flower_shop/features/auth/data/datasource/auth_datasource.dart';
import 'package:flower_shop/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/auth/data/repos/auth_repo_imp.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'auth_repo_imp_test.mocks.dart';

@GenerateMocks([AuthDatasource])
void main() {
  late MockAuthDatasource mockDatasource;
  late AuthRepoImp repo;

  setUp(() {
    mockDatasource = MockAuthDatasource();
    repo = AuthRepoImp(mockDatasource);
  });
  final email = "test@test.com";
  final password = "123456";

  group("AuthRepoImp.login()", () {
    test("returns SuccessApiResult when datasource returns valid response", () async {
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
      when(mockDatasource.login(any))
          .thenAnswer((_) async => SuccessApiResult<LoginResponse>(data: fakeResponse));

      // ACT
      final result = await repo.login(email, password);
      // ASSERT
      expect(result, isA<SuccessApiResult<LoginModel>>());
      final data = (result as SuccessApiResult).data;
      expect(data.message, "success");
      expect(data.token, "abc123");
      expect(data.user.firstName, "Nouran");
      verify(mockDatasource.login(any)).called(1);
    });

    test("returns ErrorApiResult when datasource returns ErrorApiResult", () async {
      // ARRANGE
      when(mockDatasource.login(any))
          .thenAnswer((_) async => ErrorApiResult<LoginResponse>(error: "network error"));
      // ACT
      final result = await repo.login(email, password);
      // ASSERT
      expect(result, isA<ErrorApiResult<LoginModel>>());
      expect((result as ErrorApiResult).error, "network error");
      verify(mockDatasource.login(any)).called(1);
    });

    test("returns ErrorApiResult with Unknown error when datasource returns unexpected result", () async {
      // ARRANGE
      when(mockDatasource.login(any))
          .thenAnswer((_) async => null); 
      // ACT
      final result = await repo.login(email, password);
      // ASSERT
      expect(result, isA<ErrorApiResult<LoginModel>>());
      expect((result as ErrorApiResult).error, "Unknown error");
      verify(mockDatasource.login(any)).called(1);
    });
  });
}
