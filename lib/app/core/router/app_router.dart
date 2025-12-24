import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/di/di.dart';
import '../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart';
import '../../features/auth/presentation/forget_password/pages/forget_password_page.dart';
import '../../features/auth/presentation/reset_code/manager/reset_code_cubit.dart';
import '../../features/auth/presentation/reset_code/pages/reset_code_page.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.forgetPassword,
  routes: [
    GoRoute(
      path: RouteNames.forgetPassword,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ForgetPasswordCubit>(),
        child: const ForgetPasswordPage(),
      ),
    ),

    GoRoute(
      path: RouteNames.resetCode,
      builder: (context, state) {
        final email = state.extra as String;
        return BlocProvider(
          create: (_) => getIt<VerifyResetCodeCubit>(param1: email),
          child:  ResetCodePage(email: email,),
        );
      },
    ),
  ],
);