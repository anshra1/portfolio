import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:equatable/equatable.dart';

import 'window_size_class.dart';

/// Material Design 3 compliant breakpoint configuration.
///
/// Defines the width thresholds for each window size class:
/// - Compact: < 600dp (phones)
/// - Medium: 600-839dp (tablets portrait, foldables)
/// - Expanded: 840-1199dp (tablets landscape, small laptops)
/// - Large: 1200-1535dp (laptops, desktops)
/// - Extra Large: >= 1536dp (large monitors, TVs)
///
/// Reference: https://m3.material.io/foundations/layout/applying-layout
class BreakpointConfiguration extends Equatable {
  /// Creates a new [BreakpointConfiguration] instance with M3 defaults.
  const BreakpointConfiguration({
    this.compact = 600,
    this.medium = 840,
    this.expanded = 1200,
    this.large = 1536,
  });

  /// Width threshold for compact window class (phones).
  /// Screens narrower than this are considered compact.
  final double compact;

  /// Width threshold for medium window class (small tablets).
  /// Screens narrower than this (but >= compact) are considered medium.
  final double medium;

  /// Width threshold for expanded window class (tablets, small laptops).
  /// Screens narrower than this (but >= medium) are considered expanded.
  final double expanded;

  /// Width threshold for large window class (desktops).
  /// Screens narrower than this (but >= expanded) are considered large.
  /// Screens wider than or equal to this are considered extra-large.
  final double large;

  /// Material Design 3 default breakpoints.
  static const m3 = BreakpointConfiguration();

  /// Determines the [WindowSizeClass] for a given [width].
  WindowSizeClass getWindowSizeClass(double width) {
    if (width < compact) {
      return WindowSizeClass.compact;
    } else if (width < medium) {
      return WindowSizeClass.medium;
    } else if (width < expanded) {
      return WindowSizeClass.expanded;
    } else if (width < large) {
      return WindowSizeClass.large;
    } else {
      return WindowSizeClass.extraLarge;
    }
  }

  @override
  List<Object?> get props => [compact, medium, expanded, large];
}
