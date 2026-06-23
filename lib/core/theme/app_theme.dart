import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          surface: AppColors.lightSurface,
          error: AppColors.error,
          onPrimary: Colors.white,
          onSurface: AppColors.lightTextPrimary,
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.display(AppColors.lightTextPrimary),
          headlineLarge: AppTextStyles.headlineLarge(AppColors.lightTextPrimary),
          headlineMedium: AppTextStyles.headlineMedium(AppColors.lightTextPrimary),
          headlineSmall: AppTextStyles.headlineSmall(AppColors.lightTextPrimary),
          bodyLarge: AppTextStyles.bodyLarge(AppColors.lightTextPrimary),
          bodyMedium: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
          labelMedium: AppTextStyles.labelMedium(AppColors.lightTextPrimary),
          labelSmall: AppTextStyles.labelSmall(AppColors.lightTextSecondary),
        ),
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryLight,
          surface: AppColors.darkSurface,
          error: AppColors.error,
          onPrimary: AppColors.darkTextPrimary,
          onSurface: AppColors.darkTextPrimary,
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.display(AppColors.darkTextPrimary),
          headlineLarge: AppTextStyles.headlineLarge(AppColors.darkTextPrimary),
          headlineMedium: AppTextStyles.headlineMedium(AppColors.darkTextPrimary),
          headlineSmall: AppTextStyles.headlineSmall(AppColors.darkTextPrimary),
          bodyLarge: AppTextStyles.bodyLarge(AppColors.darkTextPrimary),
          bodyMedium: AppTextStyles.bodyMedium(AppColors.darkTextSecondary),
          labelMedium: AppTextStyles.labelMedium(AppColors.darkTextPrimary),
          labelSmall: AppTextStyles.labelSmall(AppColors.darkTextSecondary),
        ),
        useMaterial3: true,
      );
}
