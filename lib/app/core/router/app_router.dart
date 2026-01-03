import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/app_start/presentation/pages/app_start_page.dart';
import 'package:flower_shop/features/auth/presentation/signup/pages/signup_screen.dart';
import 'package:flower_shop/features/auth/presentation/login/pages/login_page.dart';
import 'package:flower_shop/features/nav_bar/presentation/manager/nav_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart';
import '../../../features/auth/presentation/forget_password/pages/forget_password_page.dart';
import '../../../features/auth/presentation/reset_password/manager/reset_password_cubit.dart';
import '../../../features/auth/presentation/reset_password/pages/reset_password.dart';
import '../../../features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart';
import '../../../features/auth/presentation/verify_reset_code/pages/verify_reset_code_page.dart';
import '../../../features/e_commerce/presentation/categories/pages/categories_page.dart';
import '../../../features/e_commerce/presentation/occasion/pages/occasion_page.dart';
import '../../../features/home/domain/models/occasion_model.dart';
import '../../../features/e_commerce/presentation/product details/manger/product_details_cubit/product_details_cubit.dart';
import '../../../features/e_commerce/presentation/product details/pages/product_details_page.dart';
import '../../../features/nav_bar/presentation/pages/app_sections.dart';
import '../../config/di/di.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.appStart, //  start here
  routes: [
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteNames.occasionPage,
      builder: (context, state) =>
          OccasionPage(occasions: state.extra as List<OccasionModel>),
    ),
    GoRoute(
      path: RouteNames.appStart,
      builder: (context, state) => const AppStartPage(),
    ),

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
        final email = state.extra as String;
        return BlocProvider(
          create: (_) => getIt<ResetPasswordCubit>(param1: email),
          child: ResetPasswordPage(),
        );
      },
    ),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<NavCubit>(),
          child: const AppSections(),
        );
      },
    ),

    GoRoute(
      path: RouteNames.categories,
      builder: (context, state) => CategoriesPage(),
    ),

    GoRoute(
      path: RouteNames.productDetails,
      builder: (context, state) {
        final productId = state.extra as String;
        // const hardcodedProductId = '673e1cd711599201718280fb';
        return BlocProvider(
          create: (_) => getIt<ProductDetailsCubit>(param1: productId),
          child: ProductDetailsPage(productId: productId),
        );
      },
    ),

  ],
);
