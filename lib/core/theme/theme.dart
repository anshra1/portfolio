import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_typography.dart';

class AppTheme {
  // Private constructor
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Dimensions
  // ---------------------------------------------------------------------------
  static const double _borderRadiusValue = 12;

  // ---------------------------------------------------------------------------
  // Theme Definition
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // scaffoldBackgroundColor uses the Neutral color
      scaffoldBackgroundColor: AppColors.neutral,

      // 1. Color Scheme Configuration
      colorScheme: const ColorScheme(
        brightness: Brightness.light,

        // Primary
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer:
            AppColors.tertiary, // Using tertiary as a lighter primary container
        onPrimaryContainer: AppColors.secondary,

        // Secondary
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer:
            AppColors.gray200, // Gray 200 equivalent for secondary container
        onSecondaryContainer: AppColors.secondary,

        // Tertiary
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.secondary, // Dark text on light purple
        // Error
        error: AppColors.error,
        onError: Colors.white,

        // Surface (Cards, Sheets)
        surface: AppColors.surfaceWhite,
        onSurface: AppColors.secondary, // Text on surface is Secondary (Gray 900)
        onSurfaceVariant: AppColors.gray600, // Gray 600 for medium emphasis
        // Background (Scaffold)
        surfaceContainerLowest: AppColors.surfaceWhite,
        surfaceContainerLow: AppColors.neutral,

        // Outlines
        outline: AppColors.neutralVariant,
        outlineVariant: AppColors.gray200, // Gray 200
      ),

      // 2. Typography
      textTheme: AppTypography.textTheme,

      // 3. Component Themes

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceWhite,
        surfaceTintColor: Colors.transparent, // Remove M3 pink tint
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusValue),
        ),
        margin: EdgeInsets.zero,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.neutral.withOpacity(0.9), // Glassmorphism effect base
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.gray600),
      ),

      // Elevated Button (Primary Action)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppColors.primary.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadiusValue),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Outlined Button (Secondary Action)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,
          side: const BorderSide(color: AppColors.neutralVariant), // Border color
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: const StadiumBorder(), // Often pill-shaped in modern UI
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Input Decoration (Text Fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusValue),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusValue),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusValue),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusValue),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.neutralVariant),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.gray600, // Gray 600 default
        size: 24,
      ),
    );
  }
}
