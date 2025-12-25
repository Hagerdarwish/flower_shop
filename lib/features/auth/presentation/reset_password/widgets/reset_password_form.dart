import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../../../../../app/core/widgets/custom_button.dart';
import '../../../../../app/core/widgets/custom_text_form_field.dart';
import '../../../../../app/core/widgets/password_text_form_field.dart';
import '../manager/reset_password_cubit.dart';
import '../manager/reset_password_intents.dart';


class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();

    return Form(
      key: cubit.formKey,
      onChanged: () =>
          cubit.doIntent(ResetPasswordIntent.formChanged),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            LocaleKeys.resetPassword.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.instruction.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 40),
          CustomTextFormField(
            controller: cubit.emailController,
            label: LocaleKeys.email.tr(),
            hint: LocaleKeys.enterYourEmail.tr(),
            validator: Validators.validateEmail,
          ),

          const SizedBox(height: 16),

          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            buildWhen: (p, c) =>
            p.togglePasswordVisibility !=
                c.togglePasswordVisibility,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.newPasswordController,
                label: LocaleKeys.newPassword.tr(),
                hint: LocaleKeys.enterPassword.tr(),
                isVisible: state.togglePasswordVisibility,
                onToggleVisibility: () => cubit.doIntent(
                  ResetPasswordIntent.togglePasswordVisibility,
                ),
                validator: Validators.validatePassword,
              );
            },
          ),

          const SizedBox(height: 32),

          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            buildWhen: (p, c) =>
            p.isFormValid != c.isFormValid ||
                p.resource.status != c.resource.status,
            builder: (context, state) {
              return CustomButton(
                text: LocaleKeys.confirm.tr(),
                isEnabled: state.isFormValid,
                isLoading:
                state.resource.status == Status.loading,
                onPressed: () => cubit.doIntent(
                  ResetPasswordIntent.submit,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
