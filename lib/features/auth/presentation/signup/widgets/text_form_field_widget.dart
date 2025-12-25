import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.obscureText = false,
    required this.label,
    this.focusNode,
    this.keyboardType,
    required this.hint,
    this.validator,
    this.onChanged,
  });
  final bool obscureText;
  final String label;
  final String hint;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        keyboardType: keyboardType,
        cursorColor: AppColors.pink,
        validator: validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hint: Text(
            hint,
            style: textTheme.labelSmall!.copyWith(color: AppColors.grey2),
          ),
          labelText: label,
        ),
      ),
    );
  }
}
