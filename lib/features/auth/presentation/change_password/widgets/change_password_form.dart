import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../../../../../app/core/widgets/custom_button.dart';
import '../../../../../app/core/widgets/password_text_form_field.dart';
import '../../reset_password/manager/reset_password_intents.dart';
import '../manager/change_password_cubit.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();

    return Form(
      key: cubit.formKey,
      onChanged: () => cubit.doIntent(const FormChangedIntent()),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Current Password
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) =>
                p.currentPasswordVisible != c.currentPasswordVisible,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.currentPasswordController,
                label: 'Current Password',
                isVisible: state.currentPasswordVisible,
                onToggleVisibility: cubit.toggleCurrentPasswordVisibility,
                validator: Validators.validatePassword,
                hint: 'Enter current password',
              );
            },
          ),
          const SizedBox(height: 20),

          // New Password
          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            buildWhen: (p, c) => p.newPasswordVisible != c.newPasswordVisible,
            builder: (context, state) {
              return PasswordTextFormField(
                controller: cubit.newPasswordController,
                label: 'New Password',
                isVisible: state.newPasswordVisible,
                onToggleVisibility: cubit.toggleNewPasswordVisibility,
                validator: Validators.validatePassword,
                hint: 'Enter new password',
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
                label: 'Confirm Password',
                isVisible: state.confirmPasswordVisible,
                onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
                validator: (val) {
                  if (val != cubit.newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                hint: 'Confirm new password',
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
                text: 'Update',
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
