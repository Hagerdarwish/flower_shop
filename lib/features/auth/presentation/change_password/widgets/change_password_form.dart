import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/auth/presentation/change_password/manager/change_password_intents.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../../../../../app/core/widgets/custom_button.dart';
import '../../../../../app/core/widgets/password_text_form_field.dart';
import '../manager/change_password_cubit.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();

    return Form(
      key: cubit.formKey,
      onChanged: () => cubit.doIntent(FormChangedIntent()),
      child: Column(
        children: [
          const SizedBox(height: 20),
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) =>
                p.currentPasswordVisible != c.currentPasswordVisible,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.currentPasswordController,
                label: LocaleKeys.currentPassword.tr(),
                isVisible: state.currentPasswordVisible,
                onToggleVisibility: () =>
                    cubit.doIntent(const ToggleCurrentPasswordVisibility()),
                validator: Validators.validatePassword,
                hint: LocaleKeys.enterCurrentPassword.tr(),
              );
            },
          ),
          const SizedBox(height: 20),

          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) => p.newPasswordVisible != c.newPasswordVisible,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.newPasswordController,
                label: LocaleKeys.newPassword.tr(),
                isVisible: state.newPasswordVisible,
                onToggleVisibility: () =>
                    cubit.doIntent(const ToggleNewPasswordVisibility()),
                validator: Validators.validatePassword,
                hint: LocaleKeys.enterNewPassword.tr(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Confirm Password
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) =>
                p.confirmPasswordVisible != c.confirmPasswordVisible,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.confirmPasswordController,
                label: LocaleKeys.confirmPassword.tr(),
                isVisible: state.confirmPasswordVisible,
                onToggleVisibility: () =>
                    cubit.doIntent(const ToggleConfirmPasswordVisibility()),
                validator: (val) {
                  if (val != cubit.newPasswordController.text) {
                    return LocaleKeys.passwordDontMatch;
                  }
                  return null;
                },
                hint: LocaleKeys.confirmNewPassword.tr(),
              );
            },
          ),
          const SizedBox(height: 32),
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) =>
                p.isFormValid != c.isFormValid ||
                p.resource.status != c.resource.status,
            builder: (context, state) {
              return CustomButton(
                text: LocaleKeys.update.tr(),
                isEnabled: state.isFormValid,
                isLoading: state.resource.status == Status.loading,
                onPressed: () =>
                    cubit.doIntent(const SubmitChangePasswordIntent()),
              );
            },
          ),
        ],
      ),
    );
  }
}
