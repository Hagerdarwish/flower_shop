import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/fun_helper/validators_helper.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/show_app_dialog.dart';
import '../../../../../core/widgets/show_snak_bar.dart';
import '../manager/forget_password_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
      previous.resource.status != current.resource.status,
      listener: (context, state) {
        final email = context.read<ForgetPasswordCubit>().emailController.text.trim();
        if (state.resource.status == Status.success) {
          showAppSnackbar(
            context,
            LocaleKeys.validation_check_email_for_verification_code.tr(),
          );
          context.push(RouteNames.verifyResetCode,extra: email,);
        }

        if (state.resource.status == Status.error) {
          showAppDialog(
            context,
            message: state.resource.error ??
                LocaleKeys.errors_an_error_occurred.tr(),
            isError: true,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();

        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  LocaleKeys.auth_forgetPassword.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  LocaleKeys.hints_associatedEmail.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: cubit.emailController,
                  label: LocaleKeys.auth_email.tr(),
                  hint: LocaleKeys.hints_enterEmail.tr(),
                  validator: Validators.validateEmail,
                  onChanged: (_) => cubit.doIntent(const FormChangedIntent()),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  isEnabled: state.isFormValid,
                  isLoading: state.resource.status == Status.loading,
                  text: LocaleKeys.auth_continue.tr(),
                  onPressed: () => cubit.doIntent(const SubmitForgetPasswordIntent()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}