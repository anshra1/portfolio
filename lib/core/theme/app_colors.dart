import 'package:flutter/material.dart';

class AppColors {
  // Private constructor
  AppColors._();

  // ---------------------------------------------------------------------------
  // Core Color Palette
  // ---------------------------------------------------------------------------
  /// **Primary**: #8B5CF6 - Main brand color (Violet 500)
  /// Used for: Main buttons, active states, key highlights.
  static const Color primary = Color(0xFF8B5CF6);

  /// **Secondary**: #111827 - Dark contrast color (Gray 900)
  /// Used for: High-contrast elements, dark backgrounds, high-emphasis text.
  static const Color secondary = Color(0xFF111827);

  /// **Tertiary**: #F3E8FF - Accent/Decorative color (Purple 100)
  /// Used for: Subtle backgrounds, tags, decorative elements.
  static const Color tertiary = Color(0xFFF3E8FF);

  /// **Neutral**: #F7F8FA - Main background color
  /// Used for: Scaffolds, app backgrounds.
  static const Color neutral = Color(0xFFF7F8FA);

  /// **Neutral Variant**: #9CA3AF - Muted/Outline color (Gray 400)
  /// Used for: Borders, disabled states, low-emphasis text/icons.
  static const Color neutralVariant = Color(0xFF9CA3AF);

  /// **Error**: #EF4444 - Semantic error color (Red 500)
  /// Used for: Validation errors, destructive actions.
  static const Color error = Color(0xFFEF4444);

  // ---------------------------------------------------------------------------
  // Additional Surface/Helper Colors
  // ---------------------------------------------------------------------------
  static const Color surfaceWhite = Colors.white;
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray200 = Color(0xFFE5E7EB);
}
