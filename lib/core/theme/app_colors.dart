import 'package:flutter/material.dart';

/// Centralized definition of application seed colors.
/// These seeds are used by the theme generator to create the full color palette.
class AppColors {
  const AppColors._();

  // Primary: A nice purple from homepage.html (#8B5CF6)
  static const primary = Color(0xFF8B5CF6);

  // Secondary: Deep purple for monochromatic harmony (#6D28D9 - violet-700)
  static const secondary = Color(0xFF6D28D9);

  // Tertiary: Pink for complementary accents (#F472B6 - pink-400)
  static const tertiary = Color(0xFFF472B6);

  // Neutral: Dark background color (#111827 - gray-900)
  static const neutral = Color(0xFF111827);

  // Neutral Variant: Mid-tone gray for outlines/surfaces (#4B5563 - gray-600)
  static const neutralVariant = Color(0xFF4B5563);

  // Error: Standard red (#EF4444 - red-500)
  static const error = Color(0xFFEF4444);

  // Additional semantic colors
  static const success = Color(0xFF10B981); // emerald-500
  static const warning = Color(0xFFF59E0B); // amber-500
  static const info = Color(0xFF3B82F6); // blue-500
}
