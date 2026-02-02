import 'package:flower_shop/features/main_profile/domain/models/text_style_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextStyleModel', () {
    test('should create instance with correct values', () {
      final model = TextStyleModel(
        fontSize: 16.0,
        fontWeight: 'bold',
        color: '#000000',
        textAlign: 'center',
        backgroundColor: '#FFFFFF',
      );

      expect(model.fontSize, 16.0);
      expect(model.fontWeight, 'bold');
      expect(model.color, '#000000');
      expect(model.textAlign, 'center');
      expect(model.backgroundColor, '#FFFFFF');
    });
  });
}
