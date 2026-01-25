import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),
      inputDecorationTheme: _getInputDecorationTheme(),
      filledButtonTheme: _getFilledButtonThemeData(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.themeColor,
      inputDecorationTheme: _getInputDecorationTheme(),
      filledButtonTheme: _getFilledButtonThemeData(),
    );
  }

  static InputDecorationTheme _getInputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  static FilledButtonThemeData _getFilledButtonThemeData() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        fixedSize: Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColors.themeColor,
        textStyle: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
