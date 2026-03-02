import 'package:flower_shop/features/main_profile/data/models/text_style_dto.dart';

class AboutAndTermsDto {
  final String section;
  final Map<String, dynamic>? title;
  final dynamic content;
  final TextStyleDto? style;
  final TextStyleDto? titleStyle;
  final TextStyleDto? contentStyle;

  AboutAndTermsDto({
    required this.section,
    this.title,
    required this.content,
    this.style,
    this.titleStyle,
    this.contentStyle,
  });

  factory AboutAndTermsDto.fromJson(Map<String, dynamic> json) {
    final style = json['style'];

    return AboutAndTermsDto(
      section: json['section'],
      title: json['title'],
      content: json['content'],
      titleStyle: style is Map && style['title'] != null
          ? TextStyleDto.fromJson(style['title'])
          : style != null && style['title'] == null
          ? TextStyleDto.fromJson(style)
          : null,
      contentStyle: style is Map && style['content'] != null
          ? TextStyleDto.fromJson(style['content'])
          : style != null && style['content'] == null
          ? TextStyleDto.fromJson(style)
          : null,
    );
  }
}
