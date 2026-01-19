import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/theme.dart' show MaterialTheme;

/// Centralized definition of application typography.
///
/// This works with the static [MaterialTheme] class to provide
/// a consistent type scale.
class AppTypography {
  const AppTypography._();

  /// The base TextTheme used by the application keys mapped to
  /// Material Design 3 roles.
  static const TextTheme base = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      height: 1.12,
      letterSpacing: -0.25,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      height: 1.16,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      height: 1.22,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      height: 1.25,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      height: 1.29,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      height: 1.27,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
  );
}
