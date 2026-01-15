import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/app_density_tokens.dart';
import 'package:portfolio/core/theme/density/density_mode.dart';
import 'package:portfolio/core/theme/density/density_radius.dart';
import 'package:portfolio/core/theme/density/density_sizes.dart';
import 'package:portfolio/core/theme/density/density_spacing.dart';

/// BuildContext extensions for clean density token access.
///
/// Usage:
/// ```dart
/// Container(
///   padding: EdgeInsets.all(context.spacing.md),
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(context.radius.lg),
///   ),
///   child: Icon(Icons.star, size: context.sizes.iconMd),
/// )
/// ```
extension DensityExtensions on BuildContext {
  /// Access the full [AppDensityTokens] extension.
  AppDensityTokens get density =>
      Theme.of(this).extension<AppDensityTokens>() ?? AppDensityTokens.comfortable();

  /// Shortcut to spacing tokens.
  DensitySpacing get spacing => density.spacing;

  /// Shortcut to radius tokens.
  DensityRadius get radius => density.radius;

  /// Shortcut to size tokens.
  DensitySizes get sizes => density.sizes;

  /// Current density mode (comfortable or compact).
  DensityMode get densityMode => density.mode;

  /// Whether current mode is comfortable.
  bool get isComfortableDensity => density.mode == DensityMode.comfortable;

  /// Whether current mode is compact.
  bool get isCompactDensity => density.mode == DensityMode.compact;
}
