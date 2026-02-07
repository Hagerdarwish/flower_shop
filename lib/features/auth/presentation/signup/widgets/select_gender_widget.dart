// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_cubit.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_intent.dart';
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
    final bloc = BlocProvider.of<AuthCubit>(context);

    return Row(
      children: [
        Text(
          LocaleKeys.gender.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Radio<String>(
          value: LocaleKeys.femaleValue.tr(),
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
            bloc.doIntent(GenderChangedEvent(gender: value));
          },
        ),
        Text(
          LocaleKeys.femaleGender.tr(),
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.blackColor),
        ),
        const SizedBox(width: 20),
        Radio<String>(
          value: LocaleKeys.maleValue.tr(),
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
            bloc.doIntent(GenderChangedEvent(gender: value));
          },
        ),
        Text(
          LocaleKeys.maleGender.tr(),
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.blackColor),
        ),
      ],
    );
  }
}
