import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/auth/domain/usecase/upsert_user_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/login_model.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:flower_shop/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_cubit.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_intent.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_states.dart';

import '../../../api/datasource/auth_remote_datasource_impl_test.mocks.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase, AuthStorage,FirebaseMessaging,UpsertUserProfileUseCase])
void main() {
  late MockLoginUseCase mockUseCase;
  late MockAuthStorage mockAuthStorage;
  late MockUpsertUserProfileUseCase mockUpsertUserProfileUseCase;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late LoginCubit cubit;

  setUp(() {
    mockUseCase = MockLoginUseCase();
    mockAuthStorage = MockAuthStorage();
    mockUpsertUserProfileUseCase = MockUpsertUserProfileUseCase();
    mockFirebaseMessaging = MockFirebaseMessaging();

    cubit = LoginCubit(
      mockUpsertUserProfileUseCase,
      mockFirebaseMessaging,
      mockUseCase,
      mockAuthStorage,
    );
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
      email: email,
      photo: null,
      role: "student",
      wishlist: [],
    ),
  );

  group("PerformLogin Intent", () {
    blocTest<LoginCubit, LoginStates>(
      'emits loading then success when usecase returns SuccessApiResult',
      build: () {
        provideDummy<ApiResult<LoginModel>>(SuccessApiResult(data: loginModel));
        when(mockUseCase.call(email, password)).thenAnswer(
          (_) async => SuccessApiResult<LoginModel>(data: loginModel),
        );
        when(mockAuthStorage.saveToken(any)).thenAnswer((_) async {});
        when(mockAuthStorage.saveUser(any)).thenAnswer((_) async {});
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        PerformLogin(email: email, password: password, rememberMe: true),
      ),
      expect: () => [
        isA<LoginStates>().having(
          (s) => s.loginResource.status,
          "status",
          Status.loading,
        ),
        isA<LoginStates>().having(
          (s) => s.loginResource.data?.token,
          "token",
          "abc123",
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call(email, password)).called(1);
        verify(mockAuthStorage.saveToken("abc123")).called(1);
        verify(mockAuthStorage.saveUser(loginModel.user)).called(1);
      },
    );

    blocTest<LoginCubit, LoginStates>(
      'emits loading then error when usecase returns ErrorApiResult',
      build: () {
        provideDummy<ApiResult<LoginModel>>(
          ErrorApiResult(error: "login failed"),
        );
        when(mockUseCase.call(email, password)).thenAnswer(
          (_) async => ErrorApiResult<LoginModel>(error: "Login failed"),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        PerformLogin(email: email, password: password, rememberMe: false),
      ),
      expect: () => [
        isA<LoginStates>().having(
          (s) => s.loginResource.status,
          "status",
          Status.loading,
        ),
        isA<LoginStates>().having(
          (s) => s.loginResource.error.toString(),
          "error",
          contains("Login failed"),
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call(email, password)).called(1);
      },
    );
  });

  group("ToggleRememberMe Intent", () {
    blocTest<LoginCubit, LoginStates>(
      'updates rememberMe value in state',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(ToggleRememberMe(true)),
      expect: () => [
        isA<LoginStates>().having((s) => s.rememberMe, "rememberMe", true),
      ],
    );
  });
}
