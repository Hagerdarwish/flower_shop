import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..doIntent(LoadProfileEvent()),
        ),
        BlocProvider(create: (_) => getIt<LogoutCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(AppConstants.appName)),
        body: const Center(child: ProfileContent()),
      ),
    );
  }
}
