import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme(this.textTheme);
  final TextTheme textTheme;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff66558f),
      surfaceTint: Color(0xff66558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe9ddff),
      onPrimaryContainer: Color(0xff4d3d75),
      secondary: Color(0xff5e5791),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe4dfff),
      onSecondaryContainer: Color(0xff463f77),
      tertiary: Color(0xff87521a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdcc0),
      onTertiaryContainer: Color(0xff6a3b02),
      error: Color(0xff904a43),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff73332e),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffcac4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f35),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff1a1249),
      secondaryFixedDim: Color(0xffc7bfff),
      onSecondaryFixedVariant: Color(0xff463f77),
      tertiaryFixed: Color(0xffffdcc0),
      onTertiaryFixed: Color(0xff2d1600),
      tertiaryFixedDim: Color(0xfffeb877),
      onTertiaryFixedVariant: Color(0xff6a3b02),
      surfaceDim: Color(0xffddd8e0),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xfff1ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c2c63),
      surfaceTint: Color(0xff66558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff75649e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff352f65),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c66a1),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff532d00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff986028),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e231f),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa15851),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff38353d),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f35),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xff75649e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5c4b84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c66a1),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff544e86),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff986028),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7b4911),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c5cd),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xffece6ee),
      surfaceContainerHigh: Color(0xffe0dbe3),
      surfaceContainerHighest: Color(0xffd5d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff322258),
      surfaceTint: Color(0xff66558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff504078),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b245b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff48427a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff452400),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6d3e04),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511a15),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff763630),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4b4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f35),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xff504078),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff39295f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff48427a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff312b62),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6d3e04),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4e2a00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb7bf),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4eff7),
      surfaceContainer: Color(0xffe6e1e9),
      surfaceContainerHigh: Color(0xffd8d3db),
      surfaceContainerHighest: Color(0xffc9c5cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd0bcfe),
      surfaceTint: Color(0xffd0bcfe),
      onPrimary: Color(0xff36265d),
      primaryContainer: Color(0xff4d3d75),
      onPrimaryContainer: Color(0xffe9ddff),
      secondary: Color(0xffc7bfff),
      onSecondary: Color(0xff2f295f),
      secondaryContainer: Color(0xff463f77),
      onSecondaryContainer: Color(0xffe4dfff),
      tertiary: Color(0xfffeb877),
      onTertiary: Color(0xff4b2800),
      tertiaryContainer: Color(0xff6a3b02),
      onTertiaryContainer: Color(0xffffdcc0),
      error: Color(0xffffb4ab),
      onError: Color(0xff561e19),
      errorContainer: Color(0xff73332e),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141318),
      onSurface: Color(0xffe6e1e9),
      onSurfaceVariant: Color(0xffcac4cf),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff66558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff1a1249),
      secondaryFixedDim: Color(0xffc7bfff),
      onSecondaryFixedVariant: Color(0xff463f77),
      tertiaryFixed: Color(0xffffdcc0),
      onTertiaryFixed: Color(0xff2d1600),
      tertiaryFixedDim: Color(0xfffeb877),
      onTertiaryFixedVariant: Color(0xff6a3b02),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff3a383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff201f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe4d6ff),
      surfaceTint: Color(0xffd0bcfe),
      onPrimary: Color(0xff2b1b51),
      primaryContainer: Color(0xff9987c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffded8ff),
      onSecondary: Color(0xff241d54),
      secondaryContainer: Color(0xff9089c7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd4b0),
      onTertiary: Color(0xff3c1e00),
      tertiaryContainer: Color(0xffc18347),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cd),
      onError: Color(0xff481310),
      errorContainer: Color(0xffcc7b72),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938e99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4f3e76),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff16033c),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff3c2c63),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff0f053f),
      secondaryFixedDim: Color(0xffc7bfff),
      onSecondaryFixedVariant: Color(0xff352f65),
      tertiaryFixed: Color(0xffffdcc0),
      onTertiaryFixed: Color(0xff1e0d00),
      tertiaryFixedDim: Color(0xfffeb877),
      onTertiaryFixedVariant: Color(0xff532d00),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070c),
      surfaceContainerLow: Color(0xff1e1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff343238),
      surfaceContainerHighest: Color(0xff3f3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5edff),
      surfaceTint: Color(0xffd0bcfe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffccb9fa),
      onPrimaryContainer: Color(0xff100032),
      secondary: Color(0xfff3edff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc3bbfc),
      onSecondaryContainer: Color(0xff090038),
      tertiary: Color(0xffffede0),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffab473),
      onTertiaryContainer: Color(0xff160800),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea5),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4eef9),
      outlineVariant: Color(0xffc6c0cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4f3e76),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff16033c),
      secondaryFixed: Color(0xffe4dfff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc7bfff),
      onSecondaryFixedVariant: Color(0xff0f053f),
      tertiaryFixed: Color(0xffffdcc0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffeb877),
      onTertiaryFixedVariant: Color(0xff1e0d00),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff514f55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f24),
      surfaceContainer: Color(0xff312f35),
      surfaceContainerHigh: Color(0xff3c3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
