import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

class CustomActionText extends StatelessWidget {
  final String text;
  final void Function()? onTapAction;
  const CustomActionText({super.key, required this.text, this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child:  Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.pink),
      ),);
  }
}