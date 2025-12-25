import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/utils/dialog_utils.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_cubit.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_intent.dart';
import 'package:flower_shop/features/auth/presentation/signup/widgets/form_signup_widget.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final bloc = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
    bloc.registerUiEventStream.listen((RegisterUiEvents event) {
      if (!mounted) return;
      switch (event) {
        case NavigateToLoginEvent():
          context.go('/login');
        case ShowLoadingEvent():
          DialogUtils.showLoading(
            context,
            LocaleKeys.loading.tr(),
            AppColors.pink,
          );
        case HideLoadingEvent():
          DialogUtils.hideLoading(context);
        case ShowSuccessDialogEvent():
          DialogUtils.showMessage(
            context,
            LocaleKeys.registrationSuccessful.tr(),
            titleMessage: LocaleKeys.success.tr(),
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              context.go('/login');
            },
            actionColor: AppColors.pink,
          );
        case ShowErrorDialogEvent():
          DialogUtils.showMessage(
            context,
            event.errorMessage.toString(),
            titleMessage: LocaleKeys.error.tr(),
            posActionName: LocaleKeys.ok.tr(),
            actionColor: AppColors.pink,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            bloc.doUiIntent(NavigateToLoginEvent());
          },
        ),
        title: Text(LocaleKeys.signUp.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => bloc,
          child: SingleChildScrollView(child: const FormSignupWidget()),
        ),
      ),
    );
  }
}
