import 'package:flutter/material.dart';
import 'package:material_design_system/tokens/system_tokens.dart';

class SystemTokenToColorSchemeConverter {
  const SystemTokenToColorSchemeConverter();
  static ColorScheme convert(SystemTokens tokens, Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: tokens.primary,
      onPrimary: tokens.onPrimary,
      primaryContainer: tokens.primaryContainer,
      onPrimaryContainer: tokens.onPrimaryContainer,
      secondary: tokens.secondary,
      onSecondary: tokens.onSecondary,
      secondaryContainer: tokens.secondaryContainer,
      onSecondaryContainer: tokens.onSecondaryContainer,
      tertiary: tokens.tertiary,
      onTertiary: tokens.onTertiary,
      tertiaryContainer: tokens.tertiaryContainer,
      onTertiaryContainer: tokens.onTertiaryContainer,
      error: tokens.error,
      onError: tokens.onError,
      errorContainer: tokens.errorContainer,
      onErrorContainer: tokens.onErrorContainer,
      surface: tokens.surface,
      onSurface: tokens.onSurface,
      surfaceContainerHighest: tokens.surfaceVariant,
      onSurfaceVariant: tokens.onSurfaceVariant,
      outline: tokens.outline,
      outlineVariant: tokens.outlineVariant,
      inverseSurface: tokens.inverseSurface,
      onInverseSurface: tokens.inverseOnSurface,
      inversePrimary: tokens.inversePrimary,
      surfaceTint: tokens.surfaceTint,
      scrim: tokens.scrim,
    );
  }
}
