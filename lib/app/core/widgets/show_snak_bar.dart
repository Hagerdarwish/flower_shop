import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

void showAppSnackbar(
    BuildContext context,
    String message, ) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        backgroundColor: AppColors.green ,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
}
