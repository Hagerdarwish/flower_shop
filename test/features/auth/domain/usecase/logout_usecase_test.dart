import 'package:flower_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';
import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockRepo;
  late LogoutUsecase useCase;

  setUp(() {
    mockRepo = MockAuthRepo();
    useCase = LogoutUsecase(mockRepo);
  });

  final token = "dummy_token";
  final logoutResponse = LogoutResponse(message: "Logged out successfully");

  group("LogoutUsecase", () {
    test("returns SuccessApiResult when repo returns success", () async {
      provideDummy<ApiResult<LogoutResponse>>(
        SuccessApiResult(data: logoutResponse),
      );
      when(mockRepo.logout(token: token)).thenAnswer(
        (_) async => SuccessApiResult<LogoutResponse>(data: logoutResponse),
      );

      final result = await useCase.call(token: token);

      expect(result, isA<SuccessApiResult<LogoutResponse>>());
      final data = (result as SuccessApiResult).data;
      expect(data.message, equals("Logged out successfully"));
      verify(mockRepo.logout(token: token)).called(1);
    });

    test("returns ErrorApiResult when repo returns error", () async {
      final errorMessage = "Logout failed";
      provideDummy<ApiResult<LogoutResponse>>(
        ErrorApiResult(error: "login failed"),
      );
      when(mockRepo.logout(token: token)).thenAnswer(
        (_) async => ErrorApiResult<LogoutResponse>(error: errorMessage),
      );

      final result = await useCase.call(token: token);

      expect(result, isA<ErrorApiResult<LogoutResponse>>());
      expect((result as ErrorApiResult).error, equals(errorMessage));
      verify(mockRepo.logout(token: token)).called(1);
    });
  });
}
