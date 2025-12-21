import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.blueColor,
    ),

    scaffoldBackgroundColor: AppColors.white,

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(fontSize: 14, color: AppColors.blackColor),
      displayMedium: TextStyle(
        fontSize: 16,
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(fontSize: 16, color: Colors.black54),
      labelMedium: TextStyle(fontSize: 18, color: Colors.black),
    ),

    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: WidgetStateProperty.all(
        IconThemeData(color: AppColors.pink),      // indicatorColor: AppColors.pink,
    ),
  ));
}
