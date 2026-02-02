import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/styled_text.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  List<String> parseContent(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) return [raw];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    if (raw is Map) return raw.values.map((e) => e.toString()).toList();
    return [raw.toString()];
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final lang = locale.languageCode;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 45, title: Text(LocaleKeys.aboutUs.tr())),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.about == null || state.about!.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.about!.error != null) {
            return Center(child: Text(state.about!.error!));
          }

          return ListView.builder(
            itemCount: state.about!.data?.length,
            itemBuilder: (context, index) {
              final section = state.about!.data?[index];
              final contentList = parseContent(section?.content?[lang]);
              final titleList = parseContent(section?.title?[lang]);

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...titleList.map(
                      (t) => StyledText(text: t, style: section?.titleStyle),
                    ),
                    const SizedBox(height: 8),
                    ...contentList.map(
                      (c) => StyledText(text: c, style: section?.contentStyle),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
