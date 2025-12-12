import 'package:flutter/material.dart';
import 'package:material_design_system/src/responsive/breakpoint_configuration.dart';
import 'package:material_design_system/src/responsive/font_scaling_configuration.dart';


/// A token representing a specific text style in the design system.
@immutable
class TextStyleToken {
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double height;

  const TextStyleToken({
    required this.fontSize,
    required this.fontWeight,
    required this.letterSpacing,
    required this.height,
  });

  /// Creates a `TextStyle` from the token.
  ///
  /// If a `BuildContext` is provided, the font size will be scaled responsively.
  TextStyle call(
    BuildContext? context,
    BreakpointConfiguration breakpoints,
    FontScalingConfiguration fontScaling,
  ) {
    double responsiveFontSize = fontSize;
    if (context != null) {
      final width = MediaQuery.sizeOf(context).width;
      if (width < breakpoints.mobile) {
        // Use the base font size for mobile
      } else if (width < breakpoints.tablet) {
        responsiveFontSize *= fontScaling.tabletScaleFactor;
      } else {
        responsiveFontSize *= fontScaling.desktopScaleFactor;
      }
    }

    return TextStyle(
      fontSize: responsiveFontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Returns a new [TextStyleToken] with the [fontSize] scaled by the given [factor].
  TextStyleToken scale(double factor) {
    return TextStyleToken(
      fontSize: fontSize * factor,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
