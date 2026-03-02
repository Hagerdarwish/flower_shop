import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AboutAndTermsModel', () {
    test('should create instance with correct values', () {
      final model = AboutAndTermsModel(
        section: 'About Us',
        title: {'en': 'Welcome', 'es': 'Bienvenido'},
        content: 'This is the about us section.',
        style: null,
        titleStyle: null,
        contentStyle: null,
      );

      expect(model.section, 'About Us');
      expect(model.title, {'en': 'Welcome', 'es': 'Bienvenido'});
      expect(model.content, 'This is the about us section.');
      expect(model.style, isNull);
      expect(model.titleStyle, isNull);
      expect(model.contentStyle, isNull);
    });
  });
}
