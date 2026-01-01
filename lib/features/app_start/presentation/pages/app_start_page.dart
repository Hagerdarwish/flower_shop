import 'package:flower_shop/features/app_start/presentation/manager/app_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/app_start/presentation/manager/app_cubit.dart';
import 'package:flower_shop/features/app_start/presentation/manager/app_states.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_cubit/nav_cubit.dart';
import 'package:flower_shop/features/auth/presentation/login/pages/login_page.dart';
import '../../../nav_bar/ui/pages/nav_bar/pages/app_sections.dart';

class AppStartPage extends StatelessWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppCubit>(),
      child: Builder(
        builder: (context) {
          context.read<AppCubit>().doIntent(CheckAuth());

          return BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final authResource = state.authResource;
              if (authResource.isLoading || authResource.isInitial) {
                return const SizedBox.shrink();
              } else if (authResource.isSuccess && authResource.data == true) {
                return BlocProvider(
                  create: (_) => getIt<NavCubit>(),
                  child: const AppSections(),
                );
              } else {
                return const LoginPage();
              }
            },
          );
        },
      ),
    );
  }
}
