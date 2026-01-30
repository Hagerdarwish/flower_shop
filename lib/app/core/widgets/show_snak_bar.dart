import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

void showAppSnackbar(
  BuildContext context,
  String message, {
  Color backgroundColor = AppColors.green,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.labelSmall),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
}
