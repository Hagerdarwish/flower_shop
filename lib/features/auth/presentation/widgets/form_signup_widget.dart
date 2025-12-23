// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/validation/app_validation.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_cubit.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_intent.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_states.dart';
import 'package:flower_shop/features/auth/presentation/widgets/select_gender_widget.dart';
import 'package:flower_shop/features/auth/presentation/widgets/text_form_feild_widget.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSignupWidget extends StatelessWidget {
  const FormSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return Column(
          children: [
            Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFeildWidget(
                          keyboardType: TextInputType.text,
                          label: LocaleKeys.firstName.tr(),
                          hint: LocaleKeys.enterFirstName.tr(),
                          validator: (val) =>
                              Validators.firstNameValidator(val),
                          onChanged: (value) {
                            bloc.doIntent(
                              FirstNameChangedEvent(
                                firstName: value.toString(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: TextFormFeildWidget(
                          label: LocaleKeys.lastName.tr(),
                          hint: LocaleKeys.enterLastName.tr(),
                          validator: (val) => Validators.lastNameValidator(val),
                          onChanged: (value) {
                            bloc.doIntent(
                              LastNameChangedEvent(lastName: value.toString()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormFeildWidget(
                    validator: (val) => Validators.emailValidator(val),
                    keyboardType: TextInputType.emailAddress,
                    label: LocaleKeys.email.tr(),
                    hint: LocaleKeys.enterEmail.tr(),
                    onChanged: (value) {
                      bloc.doIntent(EmailChangedEvent(email: value.toString()));
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFeildWidget(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          label: LocaleKeys.password.tr(),
                          hint: LocaleKeys.enterPassword.tr(),
                          validator: (val) => Validators.passwordValidator(val),
                          onChanged: (value) {
                            bloc.doIntent(
                              PasswordChangedEvent(password: value.toString()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: TextFormFeildWidget(
                          obscureText: true,
                          label: LocaleKeys.confirmPassword.tr(),
                          hint: LocaleKeys.confirmPassword.tr(),
                          validator: (val) =>
                              Validators.confirmPasswordValidator(
                                val,
                                bloc.password,
                              ),
                          onChanged: (value) {
                            bloc.doIntent(
                              ConfirmPasswordChangedEvent(
                                confirmPassword: value.toString(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormFeildWidget(
                    validator: (val) => Validators.phoneValidator(val),
                    keyboardType: TextInputType.phone,
                    label: LocaleKeys.phone.tr(),
                    hint: LocaleKeys.enterPhoneNumber.tr(),
                    onChanged: (value) {
                      bloc.doIntent(PhoneChangedEvent(phone: value.toString()));
                    },
                  ),
                  const SizedBox(height: 24),
                  SelectGenderWidget(),
                  if (bloc.state.signupState?.genderError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          bloc.state.signupState!.genderError!,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  SizedBox(height: 8),
                  Text(
                    LocaleKeys.createAccount.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        bloc.doIntent(SignupEvent());
                      },
                      child: Text(
                        LocaleKeys.signupTitle.tr(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      bloc.doUiIntent(NavigateToLoginEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: LocaleKeys.alreadyHaveAccount.tr(),
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                              TextSpan(
                                text: LocaleKeys.login.tr(),
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.pink,
                                  color: AppColors.pink,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
