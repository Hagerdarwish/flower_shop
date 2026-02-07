import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AboutAndTermsDto', () {
    test('fromJson should parse correctly', () {
      final json = {
        'section': 'about',
        'title': {'en': 'About Us', 'es': 'Sobre Nosotros'},
        'content': 'We are a flower shop.',
        'style': {
          'title': {'fontSize': 20, 'color': '#000000'},
          'content': {'fontSize': 16, 'color': '#333333'},
        },
      };

      final result = AboutAndTermsDto.fromJson(json);

      expect(result.title, {'en': 'About Us', 'es': 'Sobre Nosotros'});
      expect(result.content, 'We are a flower shop.');
      expect(result.titleStyle?.fontSize, 20);
      expect(result.contentStyle?.fontSize, 16);
    });
  });
}
