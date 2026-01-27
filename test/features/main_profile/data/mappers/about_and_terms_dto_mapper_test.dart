import 'package:flower_shop/features/main_profile/data/mappers/about_and_terms_dto_mapper.dart';
import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flower_shop/features/main_profile/data/models/text_style_dto.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AboutAndTermsDtoMapper', () {
    test('should map AboutAndTermsDto to AboutAndTermsModel correctly', () {
      final dto = AboutAndTermsDto(
        section: 'about',
        title: {'en': 'About Us', 'es': 'Sobre Nosotros'},
        content: 'We are a flower shop.',
        style: TextStyleDto(
          fontSize: 14,
          fontWeight: 'normal',
          color: '#000000',
        ),
        titleStyle: TextStyleDto(
          fontSize: 18,
          fontWeight: 'bold',
          color: '#FF0000',
        ),
        contentStyle: TextStyleDto(
          fontSize: 12,
          fontWeight: 'light',
          color: '#00FF00',
        ),
      );

      final result = dto.toAboutAndTermsModel();

      expect(result, isA<AboutAndTermsModel>());
      expect(result.section, dto.section);
      expect(result.title, dto.title);
      expect(result.content, dto.content);
      expect(result.style?.fontSize, dto.style?.fontSize);
      expect(result.titleStyle?.fontWeight, dto.titleStyle?.fontWeight);
    });
  });
}
