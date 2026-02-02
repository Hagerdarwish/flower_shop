import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../../domain/models/text_style_model.dart';
import '../../domain/models/about_and_terms_model.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: Text(LocaleKeys.termsAndConditions.tr()),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final resource = state.terms;
          if (resource == null || resource.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (resource.error != null) {
            return Center(child: Text(resource.error ?? 'Error'));
          }
          final sections = resource.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return _TermsSectionWidget(section: sections[index], lang: lang);
            },
          );
        },
      ),
    );
  }
}

class _TermsSectionWidget extends StatelessWidget {
  final AboutAndTermsModel section;
  final String lang;

  const _TermsSectionWidget({required this.section, required this.lang});

  @override
  Widget build(BuildContext context) {
    final title = section.title?[lang];
    final content = section.content is Map
        ? section.content[lang]
        : section.content;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title,
              style: _toTextStyle(section.titleStyle),
              textAlign: _toTextAlign(section.titleStyle?.textAlign, lang),
            ),

          if (title != null) const SizedBox(height: 8),

          if (content is String)
            Text(
              content,
              style: _toTextStyle(section.contentStyle),
              textAlign: _toTextAlign(section.contentStyle?.textAlign, lang),
            ),

          if (content is List)
            ...content.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('• $e', style: _toTextStyle(section.contentStyle)),
              ),
            ),
        ],
      ),
    );
  }
}

TextStyle _toTextStyle(TextStyleModel? style) {
  if (style == null) return const TextStyle();

  return TextStyle(
    fontSize: style.fontSize,
    fontWeight: style.fontWeight == 'bold'
        ? FontWeight.bold
        : FontWeight.normal,
    color: _hexToColor(style.color),
    backgroundColor: _hexToColor(style.backgroundColor),
  );
}

Color? _hexToColor(String? hex) {
  if (hex == null) return null;
  return Color(int.parse(hex.replaceFirst('#', '0xff')));
}

TextAlign _toTextAlign(dynamic value, String lang) {
  if (value is String) return _mapAlign(value);
  if (value is Map) return _mapAlign(value[lang] ?? 'left');
  return TextAlign.left;
}

TextAlign _mapAlign(String v) {
  switch (v) {
    case 'center':
      return TextAlign.center;
    case 'right':
      return TextAlign.right;
    default:
      return TextAlign.left;
  }
}
