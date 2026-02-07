import 'package:flower_shop/features/main_profile/data/models/text_style_dto.dart';
import 'package:flower_shop/features/main_profile/domain/models/text_style_model.dart';

extension TextStyleMapper on TextStyleDto {
  TextStyleModel toTextStyleModel() {
    return TextStyleModel(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      backgroundColor: backgroundColor,
    );
  }
}
