// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_bloc.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_events.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_states.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectGenderWidget extends StatefulWidget {
  const SelectGenderWidget({super.key});

  @override
  State<SelectGenderWidget> createState() => _SelectGenderWidgetState();
}

class _SelectGenderWidgetState extends State<SelectGenderWidget> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);

    return Row(
      children: [
        Text(
          LocaleKeys.gender.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Radio<String>(
          value: LocaleKeys.femaleValue.tr(),
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
              bloc.gender = value.toString();
            });

            bloc.state.copywith(
              signupStateCopywith: SignupState(genderError: null),
            );
            bloc.doIntent(GenderChangedEvent(gender: value));
          },
        ),
        Text(LocaleKeys.femaleGender.tr()),
        const SizedBox(width: 20),
        Radio<String>(
          value: LocaleKeys.maleValue.tr(),
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
              bloc.gender = value.toString();
            });
            bloc.state.copywith(
              signupStateCopywith: SignupState(genderError: null),
            );
            bloc.doIntent(GenderChangedEvent(gender: value));
          },
        ),
        Text(LocaleKeys.maleGender.tr()),
      ],
    );
  }
}
