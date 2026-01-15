import 'package:flutter/material.dart';

/// Density modes for UI compactness.
///
/// - [comfortable]: Mobile/touch optimized with generous spacing
/// - [compact]: Desktop/mouse optimized with tighter spacing
enum DensityMode { comfortable, compact }

/// Derives [DensityMode] from Flutter's [VisualDensity].
///
/// Syncs with Flutter's built-in density system so Material widgets
/// and custom tokens respond consistently.
DensityMode getDensityFromContext(BuildContext context) {
  final visualDensity = Theme.of(context).visualDensity;
  // Negative vertical density = compact mode (desktop)
  return visualDensity.vertical < 0 ? DensityMode.compact : DensityMode.comfortable;
}

/// Returns [DensityMode] based on target platform.
///
/// Use this when [BuildContext] is not available (e.g., theme setup).
DensityMode getDensityFromPlatform(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return DensityMode.comfortable;
    case TargetPlatform.windows:
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
    case TargetPlatform.fuchsia:
      return DensityMode.compact;
  }
}
