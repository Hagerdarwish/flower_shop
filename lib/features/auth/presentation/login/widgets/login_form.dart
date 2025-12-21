import 'package:flower_shop/app/core/widgets/custom_text_field.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/login_options.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  const LoginForm({super.key, required this.formKey, required this.autoValidate});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode:
          widget.autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        children: [
          BuildTextFormField(
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          BuildTextFormField(
            labelText: 'Password',
            hintText: 'Enter your password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            isPassword: true,
            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 10),
          LoginOptions(
            onChanged: (isChecked) {},
          ),
          const SizedBox(height: 20),


        ],
      ),
    );
  }
}
