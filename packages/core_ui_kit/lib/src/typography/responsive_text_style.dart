import 'package:flutter/widgets.dart';

import '../responsive_layout/breakpoint_configuration.dart';
import 'font_scaling_configuration.dart';
import '../responsive_layout/screen_size_detector.dart';
import '../responsive_layout/window_size_class.dart';

/// A text style that adapts based on screen size.
///
/// [ResponsiveTextStyle] provides two ways to access the style:
/// - [resolve] - Returns the appropriate style based on current screen size
/// - [value] - Returns the base (compact/mobile) style without context
///
/// ## Usage
///
/// ### Basic with auto-scaling
/// ```dart
/// final bodyStyle = ResponsiveTextStyle(
///   base: TextStyle(fontSize: 14),
///   category: TypographyCategory.body,
/// );
///
/// // Responsive (scales based on screen size)
/// Text('Hello', style: bodyStyle.resolve(context));
///
/// // Static (always returns base)
/// Text('Hello', style: bodyStyle.value);
/// ```
///
/// ### With explicit overrides
/// ```dart
/// final heroStyle = ResponsiveTextStyle(
///   base: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
///   expanded: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
///   large: TextStyle(fontSize: 64, fontWeight: FontWeight.w500),
///   category: TypographyCategory.display,
/// );
/// ```

class ResponsiveTextStyle {
  /// Creates a responsive text style.
  ///
  /// [base] is required and represents the compact/mobile style.
  /// [category] determines how aggressively the style scales.
  /// Explicit styles ([medium], [expanded], [large], [extraLarge])
  /// override auto-scaling for their respective window classes.
  const ResponsiveTextStyle({
    required this.base,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    this.category = TypographyCategory.body,
    this.scalingConfig = const FontScalingConfiguration(),
    this.breakpoints = const BreakpointConfiguration(),
  });

  /// Creates a responsive text style that only uses explicit values (no scaling).
  ///
  /// All window classes that don't have explicit styles will use the base style.
  const ResponsiveTextStyle.explicit({
    required this.base,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    this.breakpoints = const BreakpointConfiguration(),
  }) : category = TypographyCategory.label,
       scalingConfig = FontScalingConfiguration.none;

  /// Creates a responsive style with uniform scaling (all categories scale the same).
  const ResponsiveTextStyle.uniform({
    required this.base,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
    this.breakpoints = const BreakpointConfiguration(),
  }) : category = TypographyCategory.body,
       scalingConfig = FontScalingConfiguration.uniform;

  /// The base text style (used for compact/mobile screens).
  final TextStyle base;

  /// Optional explicit style for medium window class.
  /// If null, the base style is scaled using [scalingConfig].
  final TextStyle? medium;

  /// Optional explicit style for expanded window class.
  /// If null, falls back to [medium] or scaled base.
  final TextStyle? expanded;

  /// Optional explicit style for large window class.
  /// If null, falls back to [expanded] or scaled base.
  final TextStyle? large;

  /// Optional explicit style for extra-large window class.
  /// If null, falls back to [large] or scaled base.
  final TextStyle? extraLarge;

  /// The typography category for auto-scaling.
  /// Different categories scale at different rates.
  final TypographyCategory category;

  /// The scaling configuration to use for auto-scaling.
  /// Defaults to [FontScalingConfiguration.m3].
  final FontScalingConfiguration scalingConfig;

  /// The breakpoint configuration to use for window class detection.
  /// Defaults to [BreakpointConfiguration.m3].
  final BreakpointConfiguration breakpoints;

  /// Returns the static base style (compact/mobile).
  ///
  /// Use this when you don't have a [BuildContext] or want a fixed style.
  TextStyle get value => base;

  /// Makes the style callable.
  ///
  /// - If [context] is provided: Returns the resolved responsive style.
  /// - If [context] is null: Returns the base (mobile) style.
  ///
  /// ```dart
  /// final style = ResponsiveTextStyle(base: TextStyle(fontSize: 16));
  /// Text('Hi', style: style(context)); // Dynamic
  /// Text('Hi', style: style());        // Mobile-first
  /// ```
  TextStyle call([BuildContext? context]) {
    if (context == null) return base;
    return resolve(context);
  }

  /// Resolves the appropriate text style based on current screen size.
  ///
  /// This uses [MediaQuery.sizeOf] internally for efficient rebuilds.
  TextStyle resolve(BuildContext context) {
    final windowClass = ScreenSizeDetector.of(context);
    return forWindowClass(windowClass);
  }

  /// Returns the text style for a specific [WindowSizeClass].
  ///
  /// Resolution order:
  /// 1. Check for explicit style for the window class
  /// 2. Fall back to next smaller explicit style
  /// 3. Fall back to scaled base style
  TextStyle forWindowClass(WindowSizeClass windowClass) {
    switch (windowClass) {
      case WindowSizeClass.compact:
        return base;

      case WindowSizeClass.medium:
        return medium ?? _scaledStyle(windowClass);

      case WindowSizeClass.expanded:
        return expanded ?? medium ?? _scaledStyle(windowClass);

      case WindowSizeClass.large:
        return large ?? expanded ?? medium ?? _scaledStyle(windowClass);

      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? _scaledStyle(windowClass);
    }
  }

  /// Scales the base style for the given window class.
  TextStyle _scaledStyle(WindowSizeClass windowClass) {
    final scale = scalingConfig.getScaleFactor(category, windowClass);
    if (scale == 1.0) return base;

    return base.copyWith(
      fontSize: base.fontSize != null ? base.fontSize! * scale : null,
      height: base.height, // Line height ratio stays the same
      letterSpacing: base.letterSpacing != null ? base.letterSpacing! * scale : null,
    );
  }

  /// Creates a copy of this style with the given fields replaced.
  ResponsiveTextStyle copyWith({
    TextStyle? base,
    TextStyle? medium,
    TextStyle? expanded,
    TextStyle? large,
    TextStyle? extraLarge,
    TypographyCategory? category,
    FontScalingConfiguration? scalingConfig,
    BreakpointConfiguration? breakpoints,
  }) {
    return ResponsiveTextStyle(
      base: base ?? this.base,
      medium: medium ?? this.medium,
      expanded: expanded ?? this.expanded,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      category: category ?? this.category,
      scalingConfig: scalingConfig ?? this.scalingConfig,
      breakpoints: breakpoints ?? this.breakpoints,
    );
  }

  /// Merges this style with another, with [other] taking precedence.
  ResponsiveTextStyle merge(ResponsiveTextStyle? other) {
    if (other == null) return this;
    return ResponsiveTextStyle(
      base: base.merge(other.base),
      medium: other.medium ?? medium,
      expanded: other.expanded ?? expanded,
      large: other.large ?? large,
      extraLarge: other.extraLarge ?? extraLarge,
      category: other.category,
      scalingConfig: other.scalingConfig,
      breakpoints: other.breakpoints,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResponsiveTextStyle &&
        other.base == base &&
        other.medium == medium &&
        other.expanded == expanded &&
        other.large == large &&
        other.extraLarge == extraLarge &&
        other.category == category &&
        other.scalingConfig == scalingConfig &&
        other.breakpoints == breakpoints;
  }

  @override
  int get hashCode {
    return Object.hash(
      base,
      medium,
      expanded,
      large,
      extraLarge,
      category,
      scalingConfig,
      breakpoints,
    );
  }
}
