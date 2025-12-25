import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(color: AppColors.pink),
              Text(message, style: TextStyle(color: AppColors.white)),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage(
    BuildContext context,
    String contentMessage, {
    String titleMessage = '',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    Color? backgroundColor,
    Color? textColor,
    Color? actionColor,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: TextStyle(color: actionColor, fontSize: 16),
          ),
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            negActionName,
            style: TextStyle(color: actionColor, fontSize: 16),
          ),
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: Text(titleMessage, style: TextStyle(color: textColor)),
          content: Text(contentMessage, style: TextStyle(color: textColor)),
          actions: actions,
        );
      },
    );
  }
}
