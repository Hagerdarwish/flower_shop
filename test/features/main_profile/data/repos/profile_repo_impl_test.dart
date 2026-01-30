import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/datasource/profile_remote_data_source.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/repos/profile_repo_impl.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileremoteDataSource])
void main() {
  // Provide dummy so Mockito works with generic ApiResult<ProfileResponse>
  provideDummy<ApiResult<ProfileResponse>>(
    SuccessApiResult(
      data: ProfileResponse(message: "", profileUserModel: ProfileUserModel()),
    ),
  );

  late MockProfileremoteDataSource mockRemote;
  late ProfileRepoImpl repo;

  setUp(() {
    mockRemote = MockProfileremoteDataSource();
    repo = ProfileRepoImpl(profileRemoteDataSource: mockRemote);
  });

  group('GetCurrentUser', () {
    test('returns SuccessApiResult<ProfileUserModel> on success', () async {
      const token = "Bearer token";

      final response = ProfileResponse(
        message: "success",
        profileUserModel: ProfileUserModel(
          id: "1",
          firstName: "Rahma",
          email: "rahma@test.com",
        ),
      );

      when(
        mockRemote.getProfile(token),
      ).thenAnswer((_) async => SuccessApiResult(data: response));

      final result = await repo.getCurrentUser(token);

      expect(result, isA<SuccessApiResult<ProfileUserModel>>());

      final data = (result as SuccessApiResult).data;
      expect(data.firstName, "Rahma");
      expect(data.email, "rahma@test.com");

      verify(mockRemote.getProfile(token)).called(1);
    });

    test('returns ErrorApiResult when remote fails', () async {
      const token = "Bearer token";

      when(
        mockRemote.getProfile(token),
      ).thenAnswer((_) async => ErrorApiResult(error: "401"));

      final result = await repo.getCurrentUser(token);

      expect(result, isA<ErrorApiResult<ProfileUserModel>>());
    });
  });

  group("Get About Data", () {
    test('should return about json correctly', () async {
      final dtoList = [
        AboutAndTermsDto(
          section: 'title',
          content: {'en': 'About App', 'ar': 'عن التطبيق'},
          title: null,
          style: null,
          titleStyle: null,
          contentStyle: null,
        ),
        AboutAndTermsDto(
          section: 'intro',
          content: {'en': 'Welcome', 'ar': 'مرحبا'},
          title: null,
          style: null,
          titleStyle: null,
          contentStyle: null,
        ),
      ];

      when(mockRemote.getAboutData()).thenAnswer((_) async => dtoList);

      final result = await repo.getAboutData();

      expect(result, isA<List<AboutAndTermsModel>>());
      expect(result.length, dtoList.length);

      expect(result[0].section, dtoList[0].section);
      expect(result[0].content['en'], dtoList[0].content['en']);
      expect(result[1].section, dtoList[1].section);
      expect(result[1].content['ar'], dtoList[1].content['ar']);
      verify(mockRemote.getAboutData()).called(1);
    });
  });

  group("Get Terms And Conditions Data", () {
    test('should return terms json correctly', () async {
      final dtoList = [
        AboutAndTermsDto(
          section: 'title',
          content: {'en': 'About App', 'ar': 'عن التطبيق'},
          title: null,
          style: null,
          titleStyle: null,
          contentStyle: null,
        ),
        AboutAndTermsDto(
          section: 'intro',
          content: {'en': 'Welcome', 'ar': 'مرحبا'},
          title: null,
          style: null,
          titleStyle: null,
          contentStyle: null,
        ),
      ];

      when(mockRemote.getTerms()).thenAnswer((_) async => dtoList);

      final result = await repo.getTerms();

      expect(result, isA<List<AboutAndTermsModel>>());
      expect(result.length, dtoList.length);

      expect(result[0].section, dtoList[0].section);
      expect(result[0].content['en'], dtoList[0].content['en']);
      expect(result[1].section, dtoList[1].section);
      expect(result[1].content['ar'], dtoList[1].content['ar']);
      verify(mockRemote.getTerms()).called(1);
    });
  });
}
