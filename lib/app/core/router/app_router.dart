import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/features/auth/presentation/reset_password/pages/reset_password.dart';
import 'package:go_router/go_router.dart';
import '../../config/di/di.dart';
import '../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart';
import '../../features/auth/presentation/forget_password/pages/forget_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/reset_password/manager/reset_password_cubit.dart';
import '../../features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart';
import '../../features/auth/presentation/verify_reset_code/pages/verify_reset_code_page.dart';

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
      path: RouteNames.verifyResetCode,
      builder: (context, state) {
        final email = state.extra as String;
        return BlocProvider(
          create: (_) => getIt<VerifyResetCodeCubit>(param1: email),
          child: VerifyResetCodePage(email: email),
        );
      },
    ),

    GoRoute(
      path: RouteNames.resetPassword,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<ResetPasswordCubit>(),
          child: const ResetPasswordPage(),
        );
      },
    ),

  ],
);
