import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../app/config/base_state/base_state.dart';
import '../../../../../app/core/ui_helper/theme/app_theme.dart';
import '../../../../../app/core/widgets/custom_action_text.dart';
import '../manager/verify_reset_code_cubit.dart';
import '../manager/verify_reset_code_intent.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyResetCodeForm extends StatelessWidget {
  const VerifyResetCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyResetCodeCubit>();
    return BlocBuilder<VerifyResetCodeCubit, VerifyResetCodeState>(
      builder: (context, state) {
        final isLoading = state.resource.status == Status.loading;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                LocaleKeys.emailVerification.tr(), // Replace with LocaleKeys.tr()
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                LocaleKeys.instruction.tr(), // Replace with LocaleKeys.tr()
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 40),

              // OTP Field
              OtpTextField(
                numberOfFields: 6,
                borderColor: AppTheme.lightTheme.colorScheme.primary,
                showFieldAsBox: true,
                fieldWidth: 45,
                fieldHeight: 60,
                textStyle: Theme.of(context).textTheme.labelMedium!,
                onCodeChanged: (code) => cubit.doIntent(FormChangedIntent(code)),
                onSubmit: (code) {
                  cubit.doIntent(FormChangedIntent(code));
                  cubit.doIntent(SubmitVerifyCodeIntent());
                },
              ),

              if (isLoading) const SizedBox(height: 20),
              if (isLoading)
                CircularProgressIndicator(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.didNotReceive.tr(), // Replace with LocaleKeys.tr()
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 10),
                  CustomActionText(
                    text: LocaleKeys.resend.tr(),
                    onTapAction: () => cubit.doIntent(ResendCodeIntent()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



