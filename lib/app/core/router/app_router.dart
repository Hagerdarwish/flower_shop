import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_shop/features/auth/presentation/pages/signup_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signup, //  start here
  routes: [
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => SignupScreen(),
    ),
     GoRoute(
      path: RouteNames.login,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
