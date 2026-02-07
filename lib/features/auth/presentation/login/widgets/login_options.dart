import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/core/router/route_names.dart';
import 'custom_check_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';

class LoginOptions extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final bool isChecked;

  const LoginOptions({
    super.key,
    required this.onChanged,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomCheckBox(isChecked: isChecked, onChecked: onChanged),
            const SizedBox(width: 10),
            Text(
              LocaleKeys.rememberMe.tr(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            context.push(RouteNames.forgetPassword);
          },
          child: Text(
            LocaleKeys.forgotPassword.tr(),
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
