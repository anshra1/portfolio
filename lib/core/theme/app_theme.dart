import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_typography.dart';
import 'package:portfolio/core/theme/density/density.dart';
import 'package:portfolio/core/theme/theme.dart';

/// Centralized manager for Application Themes.
///
/// Uses the manual [MaterialTheme] class to produce consistent Light and Dark themes.
class AppTheme {
  const AppTheme._();

  /// The centralized material theme definition.
  static const _materialTheme = MaterialTheme(AppTypography.base);

  /// Returns the visual density based on the platform.
  static VisualDensity get _density {
    // Pro Tip: Set your ThemeData to automatically switch density based on the platform.
    if (kIsWeb) return VisualDensity.compact;
    return switch (defaultTargetPlatform) {
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => VisualDensity.compact,
      _ => VisualDensity.standard,
    };
  }

  /// The main Light Theme for the application.
  static ThemeData get light {
    return _materialTheme.lightHighContrast().copyWith(
      visualDensity: _density,
      extensions: [AppDensityTokens.adaptive(defaultTargetPlatform)],
    );
  }

  /// The main Dark Theme for the application.
  static ThemeData get dark {
    return _materialTheme.darkHighContrast().copyWith(
      visualDensity: _density,
      extensions: [AppDensityTokens.adaptive(defaultTargetPlatform)],
    );
  }
}
