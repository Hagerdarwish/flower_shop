import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetCurrentUserUsecase, AuthStorage])
void main() {
  late MockGetCurrentUserUsecase mockUsecase;
  late MockAuthStorage mockAuthStorage;
  late ProfileCubit cubit;

  setUp(() {
    mockUsecase = MockGetCurrentUserUsecase();
    mockAuthStorage = MockAuthStorage();
    cubit = ProfileCubit(mockUsecase, mockAuthStorage);
  });

  final user = ProfileUserModel(
    id: "1",
    firstName: "Rahma",
    email: "rahma@test.com",
  );

  group("LoadProfileEvent", () {
    blocTest<ProfileCubit, ProfileState>(
      'emits loading then success when profile loaded successfully',
      build: () {
        provideDummy<ApiResult<ProfileUserModel>>(SuccessApiResult(data: user));

        when(mockAuthStorage.getToken()).thenAnswer((_) async => "token");
        when(
          mockUsecase.call("Bearer token"),
        ).thenAnswer((_) async => SuccessApiResult(data: user));

        return ProfileCubit(mockUsecase, mockAuthStorage);
      },
      act: (cubit) => cubit.doIntent(LoadProfileEvent()),
      expect: () => [
        isA<ProfileState>().having((s) => s.user.isLoading, 'isLoading', true),
        isA<ProfileState>()
            .having((s) => s.user.isSuccess, 'isSuccess', true)
            .having((s) => s.user.data, 'user', user),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits error when token is null',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);

        return ProfileCubit(mockUsecase, mockAuthStorage);
      },
      act: (cubit) => cubit.doIntent(LoadProfileEvent()),
      expect: () => [
        isA<ProfileState>().having((s) => s.user.isLoading, 'isLoading', true),
        isA<ProfileState>()
            .having((s) => s.user.isError, 'isError', true)
            .having((s) => s.user.error, 'error message', 'Token not found'),
      ],
    );
  });
}
