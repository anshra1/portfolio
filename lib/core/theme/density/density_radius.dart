import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_mode.dart';

/// Density-aware border radius tokens.
///
/// Larger radii in comfortable mode create softer, touch-friendly UI.
/// Tighter radii in compact mode create crisp, professional appearance.
@immutable
class DensityRadius {
  const DensityRadius._({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  /// Comfortable radii for mobile/touch.
  const DensityRadius.comfortable() : sm = 8, md = 12, lg = 16, xl = 24;

  /// Compact radii for desktop/web.
  const DensityRadius.compact() : sm = 4, md = 8, lg = 12, xl = 16;

  /// Factory that selects values based on [DensityMode].
  factory DensityRadius.fromMode(DensityMode mode) {
    switch (mode) {
      case DensityMode.comfortable:
        return const DensityRadius.comfortable();
      case DensityMode.compact:
        return const DensityRadius.compact();
    }
  }
  final double sm;
  final double md;
  final double lg;
  final double xl;

  /// Linearly interpolate between two [DensityRadius] instances.
  static DensityRadius lerp(DensityRadius a, DensityRadius b, double t) {
    return DensityRadius._(
      sm: a.sm + (b.sm - a.sm) * t,
      md: a.md + (b.md - a.md) * t,
      lg: a.lg + (b.lg - a.lg) * t,
      xl: a.xl + (b.xl - a.xl) * t,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DensityRadius &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl;

  @override
  int get hashCode => Object.hash(sm, md, lg, xl);
}
