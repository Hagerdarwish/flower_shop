import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;
  @override
  State<LoginOptions> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<LoginOptions> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            CustomCheckBox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChanged(value);
            setState(() {});
          },
          isChecked: isTermsAccepted,
        ),
        const SizedBox(
          width: 10,
        ),
        Text("rememberMe".tr()),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Text("forgotPassword".tr(),style: TextStyle(decoration: TextDecoration.underline,),),
        )
      ],
    );
  }
}