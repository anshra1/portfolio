import 'package:flutter/material.dart';
import 'package:portfolio/core/ds/density_mode.dart';

/// Density-aware size tokens for icons, avatars, and components.
///
/// Comfortable mode uses larger sizes for visual clarity on touch.
/// Compact mode uses smaller sizes for space efficiency on desktop.
@immutable
class DensitySizes {
  const DensitySizes._({
    required this.iconSm,
    required this.iconMd,
    required this.iconLg,
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,
    required this.maxContainerWidth,
  });

  /// Comfortable sizes for mobile/touch.
  const DensitySizes.comfortable()
    : iconSm = 20,
      iconMd = 24,
      iconLg = 32,
      avatarSm = 40,
      avatarMd = 56,
      avatarLg = 72,
      maxContainerWidth = 1152;

  /// Compact sizes for desktop/web.
  const DensitySizes.compact()
    : iconSm = 16,
      iconMd = 20,
      iconLg = 24,
      avatarSm = 32,
      avatarMd = 40,
      avatarLg = 56,
      maxContainerWidth = 1152;

  /// Factory that selects values based on [DensityMode].
  factory DensitySizes.fromMode(DensityMode mode) {
    switch (mode) {
      case DensityMode.comfortable:
        return const DensitySizes.comfortable();
      case DensityMode.compact:
        return const DensitySizes.compact();
    }
  }
  // Icons
  final double iconSm;
  final double iconMd;
  final double iconLg;

  // Avatars
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;

  // Layout
  final double maxContainerWidth;

  /// Linearly interpolate between two [DensitySizes] instances.
  static DensitySizes lerp(DensitySizes a, DensitySizes b, double t) {
    return DensitySizes._(
      iconSm: a.iconSm + (b.iconSm - a.iconSm) * t,
      iconMd: a.iconMd + (b.iconMd - a.iconMd) * t,
      iconLg: a.iconLg + (b.iconLg - a.iconLg) * t,
      avatarSm: a.avatarSm + (b.avatarSm - a.avatarSm) * t,
      avatarMd: a.avatarMd + (b.avatarMd - a.avatarMd) * t,
      avatarLg: a.avatarLg + (b.avatarLg - a.avatarLg) * t,
      maxContainerWidth:
          a.maxContainerWidth + (b.maxContainerWidth - a.maxContainerWidth) * t,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DensitySizes &&
          iconSm == other.iconSm &&
          iconMd == other.iconMd &&
          iconLg == other.iconLg &&
          avatarSm == other.avatarSm &&
          avatarMd == other.avatarMd &&
          avatarLg == other.avatarLg &&
          maxContainerWidth == other.maxContainerWidth;

  @override
  int get hashCode => Object.hash(
    iconSm,
    iconMd,
    iconLg,
    avatarSm,
    avatarMd,
    avatarLg,
    maxContainerWidth,
  );
}
