import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/ui_helper/theme/app_theme.dart';
import '../manager/reset_code_cubit.dart';
import '../manager/reset_code_intent.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ResetCodeForm extends StatelessWidget {
  const ResetCodeForm({super.key});

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
                'Email Verification', // Replace with LocaleKeys.tr()
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the code sent to your email', // Replace with LocaleKeys.tr()
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

              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code?", // Replace with LocaleKeys.tr()
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 10),
                  CustomActionText(
                    text: "Resend", // Replace with LocaleKeys.tr()
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



class CustomActionText extends StatelessWidget {
  final String text;
  final void Function()? onTapAction;
  const CustomActionText({super.key, required this.text, this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child:  Text(
          text,
          ),);
  }
}