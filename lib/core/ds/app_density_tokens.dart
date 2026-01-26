import 'package:flutter/material.dart';
import 'package:portfolio/core/ds/density_mode.dart';
import 'package:portfolio/core/ds/density_radius.dart';
import 'package:portfolio/core/ds/density_sizes.dart';
import 'package:portfolio/core/ds/density_spacing.dart';

/// ThemeExtension that bundles all density tokens.
///
/// Attach to [ThemeData.extensions] to make density tokens available
/// throughout the widget tree via [Theme.of(context).extension].
@immutable
class AppDensityTokens extends ThemeExtension<AppDensityTokens> {
  const AppDensityTokens({
    required this.mode,
    required this.spacing,
    required this.radius,
    required this.sizes,
  });

  /// Comfortable tokens for mobile/touch platforms.
  factory AppDensityTokens.comfortable() => const AppDensityTokens(
    mode: DensityMode.comfortable,
    spacing: DensitySpacing.comfortable(),
    radius: DensityRadius.comfortable(),
    sizes: DensitySizes.comfortable(),
  );

  /// Compact tokens for desktop/web platforms.
  factory AppDensityTokens.compact() => const AppDensityTokens(
    mode: DensityMode.compact,
    spacing: DensitySpacing.compact(),
    radius: DensityRadius.compact(),
    sizes: DensitySizes.compact(),
  );

  /// Creates tokens based on [DensityMode].
  factory AppDensityTokens.fromMode(DensityMode mode) {
    switch (mode) {
      case DensityMode.comfortable:
        return AppDensityTokens.comfortable();
      case DensityMode.compact:
        return AppDensityTokens.compact();
    }
  }

  /// Creates tokens based on target platform.
  ///
  /// Use this in [ThemeData] setup when [BuildContext] is unavailable.
  factory AppDensityTokens.adaptive(TargetPlatform platform) {
    return AppDensityTokens.fromMode(getDensityFromPlatform(platform));
  }
  final DensityMode mode;
  final DensitySpacing spacing;
  final DensityRadius radius;
  final DensitySizes sizes;

  @override
  AppDensityTokens copyWith({
    DensityMode? mode,
    DensitySpacing? spacing,
    DensityRadius? radius,
    DensitySizes? sizes,
  }) {
    return AppDensityTokens(
      mode: mode ?? this.mode,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  AppDensityTokens lerp(covariant AppDensityTokens? other, double t) {
    if (other == null) return this;
    return AppDensityTokens(
      mode: t < 0.5 ? mode : other.mode,
      spacing: DensitySpacing.lerp(spacing, other.spacing, t),
      radius: DensityRadius.lerp(radius, other.radius, t),
      sizes: DensitySizes.lerp(sizes, other.sizes, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDensityTokens &&
          mode == other.mode &&
          spacing == other.spacing &&
          radius == other.radius &&
          sizes == other.sizes;

  @override
  int get hashCode => Object.hash(mode, spacing, radius, sizes);
}
