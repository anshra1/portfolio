import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:material_design_system/src/generators/theme_generator.dart';
import 'package:material_design_system/tokens/reference_tokens.dart';
import 'package:material_design_system/tokens/system_tokens.dart';

/// A theme generator that produces a standard Material 3 dark theme.
class StandardDarkThemeGenerator implements ThemeGenerator {
  const StandardDarkThemeGenerator();

  @override
  SystemTokens generate({required ReferenceTokens seeds}) {
    final primaryPalette = TonalPalette.fromHct(Hct.fromInt(seeds.primary.value));
    final secondaryPalette = TonalPalette.fromHct(Hct.fromInt(seeds.secondary.value));
    final tertiaryPalette = TonalPalette.fromHct(Hct.fromInt(seeds.tertiary.value));
    final neutralPalette = TonalPalette.fromHct(Hct.fromInt(seeds.neutral.value));
    final neutralVariantPalette = TonalPalette.fromHct(
      Hct.fromInt(seeds.neutralVariant.value),
    );
    final errorPalette = TonalPalette.fromHct(Hct.fromInt(seeds.error.value));
    final successPalette = TonalPalette.fromHct(Hct.fromInt(seeds.success.value));
    final warningPalette = TonalPalette.fromHct(Hct.fromInt(seeds.warning.value));
    final infoPalette = TonalPalette.fromHct(Hct.fromInt(seeds.info.value));

    return SystemTokens(
      primary: Color(primaryPalette.get(80)),
      onPrimary: Color(primaryPalette.get(20)),
      primaryContainer: Color(primaryPalette.get(30)),
      onPrimaryContainer: Color(primaryPalette.get(90)),
      secondary: Color(secondaryPalette.get(80)),
      onSecondary: Color(secondaryPalette.get(20)),
      secondaryContainer: Color(secondaryPalette.get(30)),
      onSecondaryContainer: Color(secondaryPalette.get(90)),
      tertiary: Color(tertiaryPalette.get(80)),
      onTertiary: Color(tertiaryPalette.get(20)),
      tertiaryContainer: Color(tertiaryPalette.get(30)),
      onTertiaryContainer: Color(tertiaryPalette.get(90)),
      error: Color(errorPalette.get(80)),
      onError: Color(errorPalette.get(20)),
      errorContainer: Color(errorPalette.get(30)),
      onErrorContainer: Color(errorPalette.get(90)),
      background: Color(neutralPalette.get(10)),
      onBackground: Color(neutralPalette.get(90)),
      surface: Color(neutralPalette.get(10)),
      onSurface: Color(neutralPalette.get(90)),
      surfaceVariant: Color(neutralVariantPalette.get(30)),
      onSurfaceVariant: Color(neutralVariantPalette.get(80)),
      outline: Color(neutralVariantPalette.get(60)),
      outlineVariant: Color(neutralVariantPalette.get(30)),
      scrim: Color(neutralPalette.get(0)),
      inverseSurface: Color(neutralPalette.get(90)),
      inverseOnSurface: Color(neutralPalette.get(20)),
      surfaceTint: Color(primaryPalette.get(80)),
      // Extended colors
      success: Color(successPalette.get(80)),
      onSuccess: Color(successPalette.get(20)),
      successContainer: Color(successPalette.get(30)),
      onSuccessContainer: Color(successPalette.get(90)),
      warning: Color(warningPalette.get(80)),
      onWarning: Color(warningPalette.get(20)),
      warningContainer: Color(warningPalette.get(30)),
      onWarningContainer: Color(warningPalette.get(90)),
      info: Color(infoPalette.get(80)),
      onInfo: Color(infoPalette.get(20)),
      infoContainer: Color(infoPalette.get(30)),
      onInfoContainer: Color(infoPalette.get(90)),

      inversePrimary: Color(primaryPalette.get(40)),
      surfaceContainer: Color(neutralPalette.get(12)),
      surfaceContainerLow: Color(neutralPalette.get(6)),
      surfaceContainerHigh: Color(neutralPalette.get(17)),
      surfaceContainerHighest: Color(neutralPalette.get(22)),
    );
  }
}
