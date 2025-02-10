import 'package:fakestore/app/core/theme/custom/custom_theme.dart';
import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
      inputDecorationTheme: CustomInputDecorationTheme.light,
      elevatedButtonTheme: CustomElevatedButtonTheme.light,
      outlinedButtonTheme: CustomOutlinedButtonTheme.light,
      textButtonTheme: CustomTextButtonTheme.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primary),
    );
  }
}
