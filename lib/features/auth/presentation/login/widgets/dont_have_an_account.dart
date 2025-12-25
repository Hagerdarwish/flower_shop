import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: LocaleKeys.dontHaveAnAccount.tr(),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextSpan(
            text: LocaleKeys.signUp.tr(),
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
