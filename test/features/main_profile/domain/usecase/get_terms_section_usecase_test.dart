import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_terms_section_usecase.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_current_user_usecase_test.mocks.dart';

void main() {
  late MockProfileRepo mockRepo;
  late GetTermsSectionUsecase usecase;

  setUpAll(() {
    mockRepo = MockProfileRepo();
    usecase = GetTermsSectionUsecase(mockRepo);
    provideDummy<ApiResult<UserCartsModel>>(
      SuccessApiResult<UserCartsModel>(data: UserCartsModel()),
    );
  });
  group('Get terms section use case', () {
    test('repo return get terms section success', () async {
      final fakeData = AboutAndTermsModel(
        section: 'Terms & Conditions',
        title: {'en': 'Terms', 'es': 'Términos'},
        content: 'This is the terms and conditions section.',
        style: null,
        titleStyle: null,
        contentStyle: null,
      );

      when(mockRepo.getTerms()).thenAnswer((_) async => [fakeData]);

      final result = await usecase.call();

      expect(result, isA<List<AboutAndTermsModel>>());
      expect(result.length, 1);
      expect(result[0].section, 'Terms & Conditions');
      verify(mockRepo.getTerms()).called(1);
    });
  });
}
