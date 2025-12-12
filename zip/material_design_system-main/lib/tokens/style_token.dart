import 'package:flutter/material.dart';

// Define an enum for common button shape styles
enum ButtonShapeStyle {
  /// Buttons have fully rounded (pill) corners.
  pill,
  /// Buttons have standard rounded corners based on defaultCornerRadius.
  rounded,
  /// Buttons have sharp, rectangular corners.
  rectangular,
}

// Define an enum for common card styles
enum CardStyle {
  /// Cards have a default background and elevation.
  elevated,
  /// Cards have an outline border.
  outlined,
  /// Cards have a filled background with no elevation or border.
  filled,
}

/// The single source of truth for all raw, non-color design values.
/// This class acts as the "Design DNA" for the app's non-color aesthetics.
@immutable
class StyleToken {
  // High-level Design DNA properties
  final ButtonShapeStyle buttonShapeStyle;
  final double defaultCornerRadius;
  final CardStyle cardStyle;
  final int cardElevationLevel;
  final double spacingMultiplier;
  final double fontSizeMultiplier;

  // Derived raw non-color design values
  final double cornerRadiusSmall;
  final double cornerRadiusMedium;
  final double cornerRadiusLarge;
  final double cornerRadiusXLarge;

  final double elevationLow;
  final double elevationMedium;
  final double elevationHigh;

  final double spacingExtraSmall;
  final double spacingSmall;
  final double spacingMedium;
  final double spacingLarge;
  final double spacingExtraLarge;

  final double borderWidthThin;
  final double borderWidthThick;
  final double defaultIconSize;

  // Constructor
  const StyleToken({
    // High-level Design DNA properties
    this.buttonShapeStyle = ButtonShapeStyle.rounded,
    this.defaultCornerRadius = 12.0,
    this.cardStyle = CardStyle.elevated,
    this.cardElevationLevel = 1,
    this.spacingMultiplier = 1.0,
    this.fontSizeMultiplier = 1.0,

    // Derived raw non-color design values (can be overridden if needed)
    double? cornerRadiusSmall,
    double? cornerRadiusMedium,
    double? cornerRadiusLarge,
    double? cornerRadiusXLarge,
    double? elevationLow,
    double? elevationMedium,
    double? elevationHigh,
    double? spacingExtraSmall,
    double? spacingSmall,
    double? spacingMedium,
    double? spacingLarge,
    double? spacingExtraLarge,
    double? borderWidthThin,
    double? borderWidthThick,
    double? defaultIconSize,
  })  : // Derive corner radii from defaultCornerRadius
        this.cornerRadiusSmall = cornerRadiusSmall ?? defaultCornerRadius * 0.5,
        this.cornerRadiusMedium = cornerRadiusMedium ?? defaultCornerRadius,
        this.cornerRadiusLarge = cornerRadiusLarge ?? defaultCornerRadius * 1.5,
        this.cornerRadiusXLarge = cornerRadiusXLarge ?? defaultCornerRadius * 2.0,

        // Derive elevation values (using fixed base for now, can be made dynamic)
        this.elevationLow = elevationLow ?? 2.0,
        this.elevationMedium = elevationMedium ?? 4.0,
        this.elevationHigh = elevationHigh ?? 8.0,

        // Derive spacing values from spacingMultiplier
        this.spacingExtraSmall = spacingExtraSmall ?? (4.0 * spacingMultiplier),
        this.spacingSmall = spacingSmall ?? (8.0 * spacingMultiplier),
        this.spacingMedium = spacingMedium ?? (16.0 * spacingMultiplier),
        this.spacingLarge = spacingLarge ?? (24.0 * spacingMultiplier),
        this.spacingExtraLarge = spacingExtraLarge ?? (32.0 * spacingMultiplier),

        // Fixed values for now
        this.borderWidthThin = borderWidthThin ?? 1.0,
        this.borderWidthThick = borderWidthThick ?? 2.0,
        this.defaultIconSize = defaultIconSize ?? 24.0;

  // TODO: Consider adding methods to retrieve these values dynamically if needed.
}
