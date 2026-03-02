import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_about_section_usecase.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_current_user_usecase_test.mocks.dart';

void main() {
  late MockProfileRepo mockRepo;
  late GetAboutSectionUsecase usecase;

  setUpAll(() {
    mockRepo = MockProfileRepo();
    usecase = GetAboutSectionUsecase(mockRepo);
    provideDummy<ApiResult<UserCartsModel>>(
      SuccessApiResult<UserCartsModel>(data: UserCartsModel()),
    );
  });
  group('Get about section use case', () {
    test('repo return get about section success', () async {
      final fakeData = AboutAndTermsModel(
        section: 'About Us',
        title: {'en': 'Welcome', 'es': 'Bienvenido'},
        content: 'This is the about us section.',
        style: null,
        titleStyle: null,
        contentStyle: null,
      );

      when(mockRepo.getAboutData()).thenAnswer((_) async => [fakeData]);

      final result = await usecase.call();

      expect(result, isA<List<AboutAndTermsModel>>());
      expect(result.length, 1);
      expect(result[0].section, 'About Us');
      verify(mockRepo.getAboutData()).called(1);
    });
  });
}
