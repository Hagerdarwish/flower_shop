import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/auth/presentation/signup/pages/signup_screen.dart';
import 'package:flower_shop/features/auth/presentation/login/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signup, //  start here
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
  ],
);
