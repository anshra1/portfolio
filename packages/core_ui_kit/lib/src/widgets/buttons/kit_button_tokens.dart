import 'package:flutter/material.dart';

/// Centralized design tokens for the Kit button system.
class KitButtonTokens {
  /// Default border radius for buttons.
  static const double radius = 8.0;

  /// Default padding for standard buttons.
  static const EdgeInsets paddingBase = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  /// Compact padding for ghost or secondary buttons.
  static const EdgeInsets paddingCompact = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Standard icon size within buttons.
  static const double iconSize = 20.0;
}
