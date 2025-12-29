import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_cubit.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_state.dart';
import 'package:flower_shop/features/nav_bar/pages/cart.dart';
import 'package:flower_shop/features/nav_bar/pages/category.dart';
import 'package:flower_shop/features/nav_bar/pages/home_screen.dart';
import 'package:flower_shop/features/nav_bar/pages/profie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSections extends StatelessWidget {
  const AppSections({super.key});

  @override
  Widget build(BuildContext context) {
    final NavCubit navCubit = context.watch<NavCubit>();
    Widget bodyWidget;
    switch (navCubit.state.selectedIndex) {
      case 0:
        bodyWidget = HomeScreen();
        break;
      case 1:
        bodyWidget = CategoryScreen();
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
          return BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: navCubit.updateIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppConstants.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: AppConstants.category,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: AppConstants.cart,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: AppConstants.profile,
              ),
            ],
          );
        },
      ),
    );
  }
}
