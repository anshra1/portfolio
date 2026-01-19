import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/app_density_tokens.dart';
import 'package:portfolio/core/theme/density/density_mode.dart';
import 'package:portfolio/core/theme/density/density_radius.dart';
import 'package:portfolio/core/theme/density/density_sizes.dart';
import 'package:portfolio/core/theme/density/density_spacing.dart';

/// Provides density token access via [BuildContext].
///
/// ## Usage
/// ```dart
/// import 'package:portfolio/core/theme/density/density.dart';
///
/// // Spacing (padding, margin, gaps)
/// EdgeInsets.all(context.spacing.md)
/// SizedBox(height: context.spacing.lg)
///
/// // Radius (border radius)
/// BorderRadius.circular(context.radius.lg)
///
/// // Sizes (icons, avatars)
/// Icon(Icons.star, size: context.sizes.iconMd)
/// CircleAvatar(radius: context.sizes.avatarMd / 2)
///
/// // Density mode checks
/// if (context.isCompactDensity) { /* desktop */ }
/// ```
///
/// ## Available Tokens
///
/// | Extension | Tokens |
/// |-----------|--------|
/// | `spacing` | xs, sm, md, lg, xl, xxl |
/// | `radius` | sm, md, lg, xl |
/// | `sizes` | iconSm, iconMd, iconLg, avatarSm, avatarMd, avatarLg |
///
/// ## Rules
/// - **Never hardcode** pixel values for spacing, radius, or sizes
/// - **Always use** these context extensions instead
/// - **Default to `.md`** when unsure which size to pick
extension DensityContext on BuildContext {
  /// Full [AppDensityTokens] from theme extension.
  ///
  /// Falls back to [AppDensityTokens.comfortable] if not found.
  AppDensityTokens get density =>
      Theme.of(this).extension<AppDensityTokens>() ?? AppDensityTokens.comfortable();

  // ─────────────────────────────────────────────────────────────────────────
  // SPACING
  // ─────────────────────────────────────────────────────────────────────────

  /// Spacing tokens for padding, margin, and gaps.
  ///
  /// ```dart
  /// // Padding
  /// padding: EdgeInsets.all(context.spacing.md)
  ///
  /// // Margin
  /// margin: EdgeInsets.symmetric(horizontal: context.spacing.lg)
  ///
  /// // Gaps
  /// SizedBox(width: context.spacing.sm)
  /// ```
  DensitySpacing get spacing => density.spacing;

  // ─────────────────────────────────────────────────────────────────────────
  // RADIUS
  // ─────────────────────────────────────────────────────────────────────────

  /// Radius tokens for border radius.
  ///
  /// ```dart
  /// decoration: BoxDecoration(
  ///   borderRadius: BorderRadius.circular(context.radius.lg),
  /// )
  /// ```
  DensityRadius get radius => density.radius;

  // ─────────────────────────────────────────────────────────────────────────
  // SIZES
  // ─────────────────────────────────────────────────────────────────────────

  /// Size tokens for icons and avatars.
  ///
  /// ```dart
  /// Icon(Icons.star, size: context.sizes.iconMd)
  /// CircleAvatar(radius: context.sizes.avatarSm / 2)
  /// ```
  DensitySizes get sizes => density.sizes;

  // ─────────────────────────────────────────────────────────────────────────
  // MODE CHECKS
  // ─────────────────────────────────────────────────────────────────────────

  /// Current density mode (comfortable or compact).
  DensityMode get densityMode => density.mode;

  /// `true` if comfortable density (mobile/touch).
  bool get isComfortableDensity => density.mode == DensityMode.comfortable;

  /// `true` if compact density (desktop/mouse).
  bool get isCompactDensity => density.mode == DensityMode.compact;
}
