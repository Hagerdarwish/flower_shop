import 'package:flower_shop/features/main_profile/data/mappers/text_style_dto_mapper.dart';
import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';

extension AboutAndTermsDtoMapper on AboutAndTermsDto {
  AboutAndTermsModel toAboutAndTermsModel() {
    return AboutAndTermsModel(
      section: section,
      title: title,
      content: content,
      style: style?.toTextStyleModel(),
      titleStyle: titleStyle?.toTextStyleModel(),
      contentStyle: contentStyle?.toTextStyleModel(),
    );
  }
}
