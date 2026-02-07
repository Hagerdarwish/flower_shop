import 'package:flower_shop/features/main_profile/domain/models/text_style_model.dart';

class AboutAndTermsModel {
  final String section;
  final Map<String, dynamic>? title;
  final dynamic content;
  final TextStyleModel? titleStyle;
  final TextStyleModel? contentStyle;
  final TextStyleModel? style;

  AboutAndTermsModel({
    required this.section,
    this.title,
    required this.content,
    this.style,
    this.titleStyle,
    this.contentStyle,
  });
}
