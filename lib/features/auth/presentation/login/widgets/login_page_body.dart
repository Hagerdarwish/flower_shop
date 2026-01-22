import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/widgets/show_snak_bar.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/core/widgets/language_bottom_sheet.dart';
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
          showAppSnackbar(context, "Login Successful :)");
          context.go(RouteNames.home);
        } else if (state.loginResource.isError == true) {
          showAppSnackbar(context, state.loginResource.error ?? 'Error');
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
                onPressed: () {
                  context.go(RouteNames.home);
                },
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  LocaleKeys.continueAsGuest.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
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
