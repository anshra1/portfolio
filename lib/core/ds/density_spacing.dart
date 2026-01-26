import 'package:flutter/material.dart';
import 'package:portfolio/core/ds/density_mode.dart';

/// Density-aware spacing tokens.
///
/// Values adjust based on [DensityMode]:
/// - Comfortable: Generous spacing for touch
/// - Compact: Tighter spacing for mouse precision
@immutable
class DensitySpacing {
  const DensitySpacing._({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  /// Comfortable spacing for mobile/touch.
  const DensitySpacing.comfortable()
    : xs = 4,
      sm = 8,
      md = 16,
      lg = 24,
      xl = 32,
      xxl = 48;

  /// Compact spacing for desktop/web.
  const DensitySpacing.compact() : xs = 2, sm = 4, md = 8, lg = 16, xl = 24, xxl = 32;

  /// Factory that selects values based on [DensityMode].
  factory DensitySpacing.fromMode(DensityMode mode) {
    switch (mode) {
      case DensityMode.comfortable:
        return const DensitySpacing.comfortable();
      case DensityMode.compact:
        return const DensitySpacing.compact();
    }
  }
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  /// Linearly interpolate between two [DensitySpacing] instances.
  static DensitySpacing lerp(DensitySpacing a, DensitySpacing b, double t) {
    return DensitySpacing._(
      xs: _lerpDouble(a.xs, b.xs, t),
      sm: _lerpDouble(a.sm, b.sm, t),
      md: _lerpDouble(a.md, b.md, t),
      lg: _lerpDouble(a.lg, b.lg, t),
      xl: _lerpDouble(a.xl, b.xl, t),
      xxl: _lerpDouble(a.xxl, b.xxl, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DensitySpacing &&
          xs == other.xs &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xxl == other.xxl;

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl, xxl);
}

double _lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
