import 'package:core_ui_kit/src/themes/tokens/system_tokens.dart';
import 'package:flutter/material.dart';

/// Converts [SystemTokens] to Flutter's [ColorScheme].
class SystemTokensConverter {
  SystemTokensConverter._();

  /// Converts [SystemTokens] to a [ColorScheme].
  ///
  /// The [brightness] parameter determines whether to create a light or dark scheme.
  static ColorScheme toColorScheme(SystemTokens tokens, Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      // Primary
      primary: tokens.primary,
      onPrimary: tokens.onPrimary,
      primaryContainer: tokens.primaryContainer,
      onPrimaryContainer: tokens.onPrimaryContainer,
      // Secondary
      secondary: tokens.secondary,
      onSecondary: tokens.onSecondary,
      secondaryContainer: tokens.secondaryContainer,
      onSecondaryContainer: tokens.onSecondaryContainer,
      // Tertiary
      tertiary: tokens.tertiary,
      onTertiary: tokens.onTertiary,
      tertiaryContainer: tokens.tertiaryContainer,
      onTertiaryContainer: tokens.onTertiaryContainer,
      // Error
      error: tokens.error,
      onError: tokens.onError,
      errorContainer: tokens.errorContainer,
      onErrorContainer: tokens.onErrorContainer,
      // Surface
      surface: tokens.surface,
      onSurface: tokens.onSurface,
      surfaceContainerHighest: tokens.surfaceContainerHighest,
      surfaceContainerHigh: tokens.surfaceContainerHigh,
      surfaceContainer: tokens.surfaceContainer,
      surfaceContainerLow: tokens.surfaceContainerLow,
      // Outline
      outline: tokens.outline,
      outlineVariant: tokens.outlineVariant,
      // Inverse
      inverseSurface: tokens.inverseSurface,
      onInverseSurface: tokens.inverseOnSurface,
      inversePrimary: tokens.inversePrimary,
      // Scrim
      scrim: tokens.scrim,
      // Surface tint
      surfaceTint: tokens.surfaceTint,
    );
  }

  /// Creates a [ThemeData] from [SystemTokens].
  ///
  /// This is a convenience method that creates a complete [ThemeData]
  /// with the [ColorScheme] derived from the tokens.
  static ThemeData toThemeData(
    SystemTokens tokens, {
    required Brightness brightness,
    bool useMaterial3 = true,
  }) {
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: toColorScheme(tokens, brightness),
    );
  }
}
