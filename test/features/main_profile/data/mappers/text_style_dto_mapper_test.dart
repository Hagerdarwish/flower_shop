import 'package:flower_shop/features/main_profile/data/mappers/text_style_dto_mapper.dart';
import 'package:flower_shop/features/main_profile/data/models/text_style_dto.dart';
import 'package:flower_shop/features/main_profile/domain/models/text_style_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextStyleDtoMapper', () {
    test('should map TextStyleDto to TextStyleModel correctly', () {
      final dto = TextStyleDto(
        fontSize: 16,
        fontWeight: 'bold',
        color: '#FF5733',
      );

      final result = dto.toTextStyleModel();

      expect(result, isA<TextStyleModel>());
      expect(result.fontSize, dto.fontSize);
      expect(result.fontWeight, dto.fontWeight);
      expect(result.color, dto.color);
    });
  });
}
