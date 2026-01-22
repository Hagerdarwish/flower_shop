import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/pages/categories_page.dart';
import 'package:flower_shop/features/main_profile/presentation/screens/profile_screen.dart';

import 'package:flower_shop/features/nav_bar/presentation/manager/nav_cubit.dart';
import 'package:flower_shop/features/nav_bar/presentation/manager/nav_state.dart';
import 'package:flower_shop/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart.dart';
import 'home_screen.dart';

class AppSections extends StatelessWidget {
  const AppSections({super.key});

  @override
  Widget build(BuildContext context) {
    final NavCubit navCubit = context.watch<NavCubit>();
    Widget bodyWidget;
    switch (navCubit.state.selectedIndex) {
      case 0:
        bodyWidget = HomePage();
        break;
      case 1:
        bodyWidget = CategoriesPage();
        break;
      case 2:
        bodyWidget = CartScreen();
        break;
      case 3:
        bodyWidget = ProfileScreen();
        break;
      default:
        bodyWidget = HomeScreen();
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          return NavigationBar(
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: AppConstants.home,
                enabled: true,
              ),
              NavigationDestination(
                icon: Icon(Icons.category_outlined),
                label: AppConstants.category,
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: AppConstants.cart,
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: AppConstants.profile,
                enabled: true,
              ),
            ],
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) {
              context.read<NavCubit>().updateIndex(index);
            },
          );
        },
      ),
    );
  }
}
