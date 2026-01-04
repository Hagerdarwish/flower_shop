import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import '../manager/login_cubit.dart';
import '../manager/login_intent.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.autoValidate,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _rememberMe = context.read<LoginCubit>().state.rememberMe;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final state = context.watch<LoginCubit>().state;

    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: LocaleKeys.email.tr(),
              hintText: LocaleKeys.enterYourEmail.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }

              final emailRegex = RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
              );

              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: LocaleKeys.password.tr(),
              hintText: LocaleKeys.enterYourPassword.tr(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }

              if (value.length < 6) {
                return 'Password length should be at least 6 characters';
              }

              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter';
              }

              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Password must contain at least one number';
              }

              return null;
            },
          ),
          const SizedBox(height: 22),
          // REMEMBER ME & FORGOT PASSWORD
          LoginOptions(
            isChecked: _rememberMe,
            onChanged: (value) {
              setState(() => _rememberMe = value);
              cubit.doIntent(ToggleRememberMe(value));
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: state.loginResource.isLoading == true
                ? null
                : () {
                    if (widget.formKey.currentState!.validate()) {
                      cubit.doIntent(
                        PerformLogin(
                          email: widget.emailController.text.trim(),
                          password: widget.passwordController.text.trim(),
                          rememberMe: _rememberMe,
                        ),
                      );
                    }
                  },
            child: Text(
              state.loginResource.isLoading == true
                  ? "Loading..."
                  : LocaleKeys.login.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
