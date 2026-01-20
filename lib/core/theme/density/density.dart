/// Density token system for adaptive UI compactness.
///
/// This library provides density-aware tokens that integrate with
/// Flutter's built-in [VisualDensity] system.
///
/// Usage:
/// ```dart
/// // In theme setup
/// ThemeData(
///   visualDensity: VisualDensity.adaptivePlatformDensity,
///   extensions: [
///     AppDensityTokens.adaptive(defaultTargetPlatform),
///   ],
/// )
///
/// // In widgets
/// Container(
///   padding: EdgeInsets.all(context.spacing.md),
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(context.radius.lg),
///   ),
///   child: Icon(Icons.star, size: context.sizes.iconMd),
/// )
/// ```
library;

import 'package:flutter/material.dart' show VisualDensity;

export 'app_density_tokens.dart';
export 'density_context.dart';
export 'density_mode.dart';
export 'density_radius.dart';
export 'density_sizes.dart';
export 'density_spacing.dart';
