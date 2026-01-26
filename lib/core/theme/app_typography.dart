import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class AppTypography {
  // Private constructor
  AppTypography._();

  static TextTheme get textTheme {
    // Using standard Flutter typography (San Francisco on iOS, Roboto on Android, etc.)
    const baseTextTheme = Typography.englishLike2021;

    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.025,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.025,
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: AppColors.gray600,
        fontSize: 16,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: AppColors.gray600,
        fontSize: 14,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: AppColors.gray400,
        fontSize: 12,
      ),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
