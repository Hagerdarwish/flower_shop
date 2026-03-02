import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_about_section_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_terms_section_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([
  GetCurrentUserUsecase,
  AuthStorage,
  GetAboutSectionUsecase,
  GetTermsSectionUsecase,
])
void main() {
  late MockGetCurrentUserUsecase mockUsecase;
  late MockAuthStorage mockAuthStorage;
  late MockGetAboutSectionUsecase mockAboutUsecase;
  late MockGetTermsSectionUsecase mockTermsUsecase;
  late ProfileCubit cubit;

  final fakeData = AboutAndTermsModel(
    section: 'About Us',
    title: {'en': 'Welcome', 'es': 'Bienvenido'},
    content: 'This is the about us section.',
    style: null,
    titleStyle: null,
    contentStyle: null,
  );

  setUp(() {
    mockUsecase = MockGetCurrentUserUsecase();
    mockAuthStorage = MockAuthStorage();
    mockAboutUsecase = MockGetAboutSectionUsecase();
    mockTermsUsecase = MockGetTermsSectionUsecase();
    cubit = ProfileCubit(
      mockUsecase,
      mockAuthStorage,
      mockAboutUsecase,
      mockTermsUsecase,
    );
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

        return cubit;
      },
      act: (cubit) => cubit.doIntent(LoadProfileEvent()),
      expect: () => [
        isA<ProfileState>().having((s) => s.user?.isLoading, 'isLoading', true),
        isA<ProfileState>()
            .having((s) => s.user?.isSuccess, 'isSuccess', true)
            .having((s) => s.user?.data, 'user', user),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits error when token is null',
      build: () {
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(LoadProfileEvent()),
      expect: () => [
        isA<ProfileState>().having((s) => s.user?.isLoading, 'isLoading', true),
        isA<ProfileState>()
            .having((s) => s.user?.isError, 'isError', true)
            .having((s) => s.user?.error, 'error message', 'Token not found'),
      ],
    );
  });

  group('Get About Section Data', () {
    blocTest(
      'emit loading, success when get about data success',
      build: () {
        when(mockAboutUsecase.call()).thenAnswer((_) async => [fakeData]);
        return cubit;
      },

      act: (cubit) {
        return cubit.loadAboutData();
      },

      expect: () => [
        isA<ProfileState>().having(
          (s) => s.about?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.about?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        expect(cubit.state.about?.data?.first.section, fakeData.section);
        expect(cubit.state.about?.data?.length, 1);
        expect(cubit.state.about?.data?.first.title, fakeData.title);
        verify(mockAboutUsecase.call()).called(1);
      },
    );

    blocTest(
      'emit loading, error when get about data fails',
      build: () {
        when(mockAboutUsecase.call()).thenThrow(Exception("Failed to load"));
        return cubit;
      },

      act: (cubit) {
        return cubit.loadAboutData();
      },

      expect: () => [
        isA<ProfileState>().having(
          (s) => s.about?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.about?.status,
          'status',
          Status.error,
        ),
      ],

      verify: (_) {
        expect(cubit.state.about?.error, contains('Failed to load'));

        verify(mockAboutUsecase.call()).called(1);
      },
    );
  });

  group('Get Terms And Conditions Section Data', () {
    blocTest(
      'emit loading, success when get terms data success',
      build: () {
        when(mockTermsUsecase.call()).thenAnswer((_) async => [fakeData]);
        return cubit;
      },

      act: (cubit) {
        return cubit.loadTermsData();
      },

      expect: () => [
        isA<ProfileState>().having(
          (s) => s.terms?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.terms?.status,
          'status',
          Status.success,
        ),
      ],

      verify: (_) {
        expect(cubit.state.terms?.data?.first.section, fakeData.section);
        expect(cubit.state.terms?.data?.length, 1);
        expect(cubit.state.terms?.data?.first.title, fakeData.title);
        verify(mockTermsUsecase.call()).called(1);
      },
    );

    blocTest(
      'emit loading, error when get terms data fails',
      build: () {
        when(mockTermsUsecase.call()).thenThrow(Exception("Failed to load"));
        return cubit;
      },

      act: (cubit) {
        return cubit.loadTermsData();
      },

      expect: () => [
        isA<ProfileState>().having(
          (s) => s.terms?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>().having(
          (s) => s.terms?.status,
          'status',
          Status.error,
        ),
      ],

      verify: (_) {
        expect(cubit.state.terms?.error, contains('Failed to load'));

        verify(mockTermsUsecase.call()).called(1);
      },
    );
  });
}
