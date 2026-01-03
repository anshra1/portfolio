import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

/// Centralized manager for Application Themes.
///
/// Uses [core_ui_kit] generators to produce consistent Light and Dark themes
/// based on the seeds defined in [AppColors].
class AppTheme {
  const AppTheme._();

  static const _seeds = ReferenceTokens(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
    neutral: AppColors.neutral,
    neutralVariant: AppColors.neutralVariant,
    error: AppColors.error,
    success: AppColors.success,
    warning: AppColors.warning,
    info: AppColors.info,
  );

  /// The main Light Theme for the application.
  static ThemeData get light {
    final tokens = const StandardLightThemeGenerator().generate(seeds: _seeds);
    return SystemTokensConverter.toThemeData(
      tokens,
      brightness: Brightness.light,
    ) ;
  }

  /// The main Dark Theme for the application.
  static ThemeData get dark {
    final tokens = const StandardDarkThemeGenerator().generate(seeds: _seeds);
    return SystemTokensConverter.toThemeData(
      tokens,
      brightness: Brightness.dark,
    );
  }
}
