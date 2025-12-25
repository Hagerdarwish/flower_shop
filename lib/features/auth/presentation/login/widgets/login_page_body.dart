import 'package:flower_shop/features/auth/presentation/login/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_cubit.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listenWhen: (previous, current) =>
          previous.loginResource != current.loginResource,
      listener: (context, state) {
        if (state.loginResource.isSuccess == true) {
          _emailController.clear();
          _passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successful :)")),
          );
        } else if (state.loginResource.isError == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.loginResource.error ?? 'Error'),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          children: [
            LoginForm(
              formKey: _formKey,
              autoValidate: false,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(LocaleKeys.continueAsGuest.tr()),
              ),
            ),
            const SizedBox(height: 15),
            const DontHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}

