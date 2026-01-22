import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/ui_helper/theme/app_theme.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..doIntent(LoadProfileEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text(AppConstants.appName, style: TextStyle())),
        body: Center(child: ProfileContent()),
      ),
    );
  }
}
