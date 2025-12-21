import 'package:flower_shop/features/nav_bar/pages/app_sections.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', //  start here
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AppSections()),
    ],
);
