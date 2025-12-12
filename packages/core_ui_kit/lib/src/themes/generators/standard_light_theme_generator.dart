import 'package:core_ui_kit/src/themes/generators/theme_generator.dart';
import 'package:core_ui_kit/src/themes/tokens/reference_tokens.dart';
import 'package:core_ui_kit/src/themes/tokens/system_tokens.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// A theme generator that produces a standard Material 3 light theme.
class StandardLightThemeGenerator implements ThemeGenerator {
  const StandardLightThemeGenerator();

  @override
  SystemTokens generate({required ReferenceTokens seeds}) {
    final primaryPalette = TonalPalette.fromHct(Hct.fromInt(seeds.primary.toARGB32()));
    final secondaryPalette = TonalPalette.fromHct(
      Hct.fromInt(seeds.secondary.toARGB32()),
    );
    final tertiaryPalette = TonalPalette.fromHct(Hct.fromInt(seeds.tertiary.toARGB32()));
    final neutralPalette = TonalPalette.fromHct(Hct.fromInt(seeds.neutral.toARGB32()));
    final neutralVariantPalette = TonalPalette.fromHct(
      Hct.fromInt(seeds.neutralVariant.toARGB32()),
    );
    final errorPalette = TonalPalette.fromHct(Hct.fromInt(seeds.error.toARGB32()));
    final successPalette = TonalPalette.fromHct(Hct.fromInt(seeds.success.toARGB32()));
    final warningPalette = TonalPalette.fromHct(Hct.fromInt(seeds.warning.toARGB32()));
    final infoPalette = TonalPalette.fromHct(Hct.fromInt(seeds.info.toARGB32()));

    return SystemTokens(
      primary: Color(primaryPalette.get(40)),
      onPrimary: Color(primaryPalette.get(100)),
      primaryContainer: Color(primaryPalette.get(90)),
      onPrimaryContainer: Color(primaryPalette.get(10)),
      secondary: Color(secondaryPalette.get(40)),
      onSecondary: Color(secondaryPalette.get(100)),
      secondaryContainer: Color(secondaryPalette.get(90)),
      onSecondaryContainer: Color(secondaryPalette.get(10)),
      tertiary: Color(tertiaryPalette.get(40)),
      onTertiary: Color(tertiaryPalette.get(100)),
      tertiaryContainer: Color(tertiaryPalette.get(90)),
      onTertiaryContainer: Color(tertiaryPalette.get(10)),
      error: Color(errorPalette.get(40)),
      onError: Color(errorPalette.get(100)),
      errorContainer: Color(errorPalette.get(90)),
      onErrorContainer: Color(errorPalette.get(10)),
      background: Color(neutralPalette.get(99)),
      onBackground: Color(neutralPalette.get(10)),
      surface: Color(neutralPalette.get(99)),
      onSurface: Color(neutralPalette.get(10)),
      surfaceVariant: Color(neutralVariantPalette.get(90)),
      onSurfaceVariant: Color(neutralVariantPalette.get(30)),
      outline: Color(neutralVariantPalette.get(50)),
      outlineVariant: Color(neutralVariantPalette.get(80)),
      scrim: Color(neutralPalette.get(0)),
      inverseSurface: Color(neutralPalette.get(20)),
      inverseOnSurface: Color(neutralPalette.get(95)),
      surfaceTint: Color(primaryPalette.get(40)),
      // Extended colors
      success: Color(successPalette.get(40)),
      onSuccess: Color(successPalette.get(100)),
      successContainer: Color(successPalette.get(90)),
      onSuccessContainer: Color(successPalette.get(10)),
      warning: Color(warningPalette.get(40)),
      onWarning: Color(warningPalette.get(100)),
      warningContainer: Color(warningPalette.get(90)),
      onWarningContainer: Color(warningPalette.get(10)),
      info: Color(infoPalette.get(40)),
      onInfo: Color(infoPalette.get(100)),
      infoContainer: Color(infoPalette.get(90)),
      onInfoContainer: Color(infoPalette.get(10)),
      inversePrimary: Color(primaryPalette.get(80)),
      surfaceContainer: Color(neutralPalette.get(94)),
      surfaceContainerLow: Color(neutralPalette.get(96)),
      surfaceContainerHigh: Color(neutralPalette.get(92)),
      surfaceContainerHighest: Color(neutralPalette.get(90)),
    );
  }
}
