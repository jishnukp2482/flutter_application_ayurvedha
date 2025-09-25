import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get primaryTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.nagmainColor,
    primaryColorLight: AppColors.nagmainColor2,
    primarySwatch: Colors.red,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        backgroundColor: const WidgetStatePropertyAll(AppColors.nagmainColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      bodySmall: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w300,
        fontSize: 15,
      ),
    ),
  );
}
