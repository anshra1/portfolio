import 'package:flutter/material.dart';

/// Centralized design tokens for the Kit button system.
class KitButtonTokens {
  /// Default border radius for buttons.
  static const double radius = 8.0;

  /// Default padding for standard buttons (Medium).
  static const EdgeInsets paddingMedium = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  /// Compact padding for small buttons.
  static const EdgeInsets paddingSmall = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  /// Large padding for prominent buttons.
  static const EdgeInsets paddingLarge = EdgeInsets.symmetric(
    horizontal: 32,
    vertical: 16,
  );

  /// Deprecated: Use [paddingMedium] instead.
  static const EdgeInsets paddingBase = paddingMedium;

  /// Compact padding for ghost or minimal buttons.
  static const EdgeInsets paddingCompact = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Standard icon size within buttons.
  static const double iconSize = 20.0;

  /// Default elevation for primary/high-emphasis buttons.
  static const double elevationPrimary = 2.0;

  /// No elevation (flat).
  static const double elevationNone = 0.0;
}
