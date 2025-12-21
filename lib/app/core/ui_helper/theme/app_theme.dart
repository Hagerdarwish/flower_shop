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

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        color: AppColors.blackColor,
        fontSize: 20,
      ),
      hintStyle: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 13,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      filled: true,
      fillColor: Colors.white,
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12,
        height: 1.3,
      ),
      enabledBorder: _border(Color(0xFF8C8C8C)),
      focusedBorder: _border(Colors.black),
      errorBorder: _border(Colors.red),
      focusedErrorBorder: _border(Colors.red),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        color: AppColors.blackColor,
      ),
      labelMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    ),
  );

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}

