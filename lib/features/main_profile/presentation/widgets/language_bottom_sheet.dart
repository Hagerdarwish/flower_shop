import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/ui_helper/color/colors.dart';
import '../../../../app/core/ui_helper/style/font_style.dart';
import '../../../../generated/locale_keys.g.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // drag handle
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              LocaleKeys.change_language.tr(),
              style: AppStyles.black14bold.copyWith(
                color: AppColors.pink,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            _LanguageTile(
              title: LocaleKeys.arabic.tr(),
              value: const Locale('ar'),
              groupValue: context.locale,
              onChanged: (loc) async {
                await context.setLocale(loc);
                if (context.mounted) Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            _LanguageTile(
              title: LocaleKeys.english.tr(),
              value: const Locale('en'),
              groupValue: context.locale,
              onChanged: (loc) async {
                await context.setLocale(loc);
                if (context.mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String title;
  final Locale value;
  final Locale groupValue;
  final ValueChanged<Locale> onChanged;

  const _LanguageTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.pink : Colors.grey.shade200,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: selected
                    ? AppStyles.black14bold.copyWith(color: Colors.black)
                    : AppStyles.black14Medium.copyWith(color: Colors.black),
              ),
            ),
            _RadioCircle(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _RadioCircle extends StatelessWidget {
  final bool selected;
  const _RadioCircle({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.pink : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.pink : Colors.transparent,
        ),
      ),
    );
  }
}
