import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_cubit.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_intent.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_state.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUsecase, AuthStorage])
void main() {
  late MockLogoutUsecase mockUseCase;
  late MockAuthStorage mockAuthStorage;
  late LogoutCubit cubit;

  setUp(() {
    mockUseCase = MockLogoutUsecase();
    mockAuthStorage = MockAuthStorage();
    cubit = LogoutCubit(mockUseCase, mockAuthStorage);
  });
  final token = "dummy_token";
  final logoutResponse = LogoutResponse(message: "Logged out successfully");

  group("PerformLogout Intent", () {
    blocTest<LogoutCubit, LogoutStates>(
      'emits loading then success when usecase returns SuccessApiResult',
      build: () {
        provideDummy<ApiResult<LogoutResponse>>(
          SuccessApiResult(data: logoutResponse),
        );
        when(mockAuthStorage.getToken()).thenAnswer((_) async => token);
        when(
          mockUseCase.call(token: 'Bearer $token'),
        ).thenAnswer((_) async => SuccessApiResult(data: logoutResponse));
        when(mockAuthStorage.clearAll()).thenAnswer((_) async {});
        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [
        isA<LogoutStates>().having(
          (s) => s.logoutResource.status,
          "status",
          Status.loading,
        ),
        isA<LogoutStates>().having(
          (s) => s.logoutResource.data?.message,
          "message",
          "Logged out successfully",
        ),
      ],
      verify: (_) {
        verify(mockAuthStorage.getToken()).called(1);
        verify(mockUseCase.call(token: 'Bearer $token')).called(1);
        verify(mockAuthStorage.clearAll()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'emits loading then error when usecase returns ErrorApiResult',
      build: () {
        provideDummy<ApiResult<LogoutResponse>>(
          ErrorApiResult(error: "Logout failed"),
        );
        when(mockAuthStorage.getToken()).thenAnswer((_) async => token);
        when(
          mockUseCase.call(token: 'Bearer $token'),
        ).thenAnswer((_) async => ErrorApiResult(error: "Logout failed"));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [
        isA<LogoutStates>().having(
          (s) => s.logoutResource.status,
          "status",
          Status.loading,
        ),
        isA<LogoutStates>().having(
          (s) => s.logoutResource.error.toString(),
          "error",
          contains("Logout failed"),
        ),
      ],
      verify: (_) {
        verify(mockAuthStorage.getToken()).called(1);
        verify(mockUseCase.call(token: 'Bearer $token')).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'emits error when token is null or empty',
      build: () {
        provideDummy<ApiResult<LogoutResponse>>(
          ErrorApiResult(error: "Logout failed"),
        );
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [
        isA<LogoutStates>(),
        isA<LogoutStates>().having(
          (s) => s.logoutResource.error,
          "error",
          "Token not found",
        ),
      ],
      verify: (_) {
        verify(mockAuthStorage.getToken()).called(1);
        verifyNever(mockUseCase.call(token: anyNamed('token')));
      },
    );
  });
}
