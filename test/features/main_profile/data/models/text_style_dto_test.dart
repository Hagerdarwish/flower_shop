import 'package:flower_shop/features/main_profile/data/models/text_style_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextStyleDto', () {
    test('fromJson should parse correctly', () {
      final json = {
        'fontSize': 16,
        'fontWeight': 'bold',
        'color': '#FFFFFF',
        'textAlign': 'center',
        'backgroundColor': '#000000',
      };

      final result = TextStyleDto.fromJson(json);

      expect(result.fontSize, 16.0);
      expect(result.fontWeight, 'bold');
      expect(result.color, '#FFFFFF');
      expect(result.textAlign, 'center');
      expect(result.backgroundColor, '#000000');
    });
  });
}
