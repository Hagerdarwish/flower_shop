import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/app_start/presentation/manager/app_cubit.dart';
import 'package:flower_shop/features/app_start/presentation/manager/app_states.dart';
import 'package:flower_shop/features/app_start/presentation/manager/app_intent.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';

import 'app_cubit_test.mocks.dart';

@GenerateMocks([AuthStorage])
void main() {
  late MockAuthStorage mockAuthStorage;
  late AppCubit cubit;

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    cubit = AppCubit(mockAuthStorage);
  });

  group("CheckAuth Intent", () {
    blocTest<AppCubit, AppState>(
      'emits [loading, success] when getRememberMe returns true',
      build: () {
        when(mockAuthStorage.getRememberMe()).thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          "status",
          Status.loading,
        ),
        isA<AppState>().having((s) => s.authResource.data, "data", true),
      ],
      verify: (_) {
        verify(mockAuthStorage.getRememberMe()).called(1);
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [loading, success] when getRememberMe returns false',
      build: () {
        when(mockAuthStorage.getRememberMe()).thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          "status",
          Status.loading,
        ),
        isA<AppState>().having((s) => s.authResource.data, "data", false),
      ],
      verify: (_) {
        verify(mockAuthStorage.getRememberMe()).called(1);
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [loading, error] when getRememberMe throws exception',
      build: () {
        when(
          mockAuthStorage.getRememberMe(),
        ).thenThrow(Exception("Auth failed"));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          "status",
          Status.loading,
        ),
        isA<AppState>().having(
          (s) => s.authResource.status,
          "status",
          Status.error,
        ),
      ],
      verify: (_) {
        verify(mockAuthStorage.getRememberMe()).called(1);
      },
    );
  });
}
