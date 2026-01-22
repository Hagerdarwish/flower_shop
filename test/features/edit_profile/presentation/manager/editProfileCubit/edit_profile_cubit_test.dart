import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_cubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_state.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_intent.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, AuthStorage])
void main() {
  late MockEditProfileUseCase mockUseCase;
  late MockAuthStorage mockAuthStorage;
  late EditProfileCubit cubit;

  setUp(() {
    mockUseCase = MockEditProfileUseCase();
    mockAuthStorage = MockAuthStorage();
    cubit = EditProfileCubit(mockUseCase, mockAuthStorage);

    provideDummy<ApiResult<EditProfileResponse>>(
      SuccessApiResult(data: EditProfileResponse()),
    );
  });

  final tToken = 'token';
  final tIntent = PerformEditProfile(
    token: tToken,
    firstName: 'Ali',
    lastName: 'Besar',
    email: 'ali@test.com',
    phone: '01000000000',
  );

  final tResponse = EditProfileResponse(
    message: 'Profile updated',
    user: User(
      id: '123',
      firstName: 'Ali',
      lastName: 'Besar',
      email: 'ali@test.com',
    ),
  );

  group('EditProfileCubit', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, success] when useCase returns SuccessApiResult',
      build: () {
        when(
          mockUseCase(
            token: anyNamed('token'),
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponse));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(tIntent),
      expect: () => [
        // استخدم Matcher بدل مقارنة الـ instances
        isA<EditProfileStates>().having(
          (s) => s.editProfileResource?.status,
          'status',
          Status.loading,
        ),
        isA<EditProfileStates>().having(
          (s) => s.editProfileResource?.status,
          'status',
          Status.success,
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits [loading, error] when useCase returns ErrorApiResult',
      build: () {
        when(
          mockUseCase(
            token: anyNamed('token'),
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(tIntent),
      expect: () => [
        isA<EditProfileStates>().having(
          (s) => s.editProfileResource?.status,
          'status',
          Status.loading,
        ),
        isA<EditProfileStates>().having(
          (s) => s.editProfileResource?.status,
          'status',
          Status.error,
        ),
      ],
    );
  });
}
