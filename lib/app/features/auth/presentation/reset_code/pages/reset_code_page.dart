import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../generated/local_keys.g.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../../../core/router/route_names.dart';
import '../manager/reset_code_cubit.dart';
import '../widgets/rest_code_form.dart';


class ResetCodePage extends StatelessWidget {
  final String email;
  const ResetCodePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          LocaleKeys.verification_emailVerification.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<VerifyResetCodeCubit, VerifyResetCodeState>(
          listenWhen: (previous, current) =>
          previous.resource.status != current.resource.status,
          listener: (context, state) {
            if (state.resource.status == Status.success &&
                state.code.isNotEmpty) {
              Navigator.of(context).pushNamed(
                RouteNames.forgetPassword, // Replace with RouteNames.resetPassword
                arguments: email,
              );
            }
            if (state.resource.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.resource.error ?? ""),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return ResetCodeForm();
          },
        ),
      ),
    );
  }
}