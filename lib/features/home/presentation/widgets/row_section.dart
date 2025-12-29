import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class RowSection extends StatelessWidget {
  final String title;
  VoidCallback onTap;
   RowSection({ required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            LocaleKeys.viewAll.tr(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              decorationColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}