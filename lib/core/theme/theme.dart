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
      secondary: Color(0xff68548e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffebddff),
      onSecondaryContainer: Color(0xff4f3d74),
      tertiary: Color(0xff894a69),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd8e7),
      onTertiaryContainer: Color(0xff6d3351),
      error: Color(0xff904a46),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad7),
      onErrorContainer: Color(0xff733330),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff73777f),
      outlineVariant: Color(0xffc3c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffebddff),
      onSecondaryFixed: Color(0xff230f46),
      secondaryFixedDim: Color(0xffd2bcfd),
      onSecondaryFixedVariant: Color(0xff4f3d74),
      tertiaryFixed: Color(0xffffd8e7),
      onTertiaryFixed: Color(0xff380724),
      tertiaryFixedDim: Color(0xfffeb0d3),
      onTertiaryFixedVariant: Color(0xff6d3351),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe8e7ef),
      surfaceContainerHighest: Color(0xffe2e2e9),
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
      secondary: Color(0xff3e2c62),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff77639d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff592340),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff995978),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e2321),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa15853),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0f1116),
      onSurfaceVariant: Color(0xff32363d),
      outline: Color(0xff4e535a),
      outlineVariant: Color(0xff696d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xff75649e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5c4b84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff77639d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5e4b83),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff995978),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7d415f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6c6cd),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffe8e7ef),
      surfaceContainerHigh: Color(0xffdcdce3),
      surfaceContainerHighest: Color(0xffd1d1d8),
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
      secondary: Color(0xff342157),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff523f77),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4d1935),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff703653),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511918),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff763632),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282c33),
      outlineVariant: Color(0xff454951),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffd0bcfe),
      primaryFixed: Color(0xff504078),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff39295f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff523f77),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3b285e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff703653),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff551f3c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb8b8bf),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f7),
      surfaceContainer: Color(0xffe2e2e9),
      surfaceContainerHigh: Color(0xffd4d4db),
      surfaceContainerHighest: Color(0xffc6c6cd),
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
      secondary: Color(0xffd2bcfd),
      onSecondary: Color(0xff38265c),
      secondaryContainer: Color(0xff4f3d74),
      onSecondaryContainer: Color(0xffebddff),
      tertiary: Color(0xfffeb0d3),
      onTertiary: Color(0xff521d3a),
      tertiaryContainer: Color(0xff6d3351),
      onTertiaryContainer: Color(0xffffd8e7),
      error: Color(0xffffb3ad),
      onError: Color(0xff571e1b),
      errorContainer: Color(0xff733330),
      onErrorContainer: Color(0xffffdad7),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc3c6cf),
      outline: Color(0xff8d9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff66558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffebddff),
      onSecondaryFixed: Color(0xff230f46),
      secondaryFixedDim: Color(0xffd2bcfd),
      onSecondaryFixedVariant: Color(0xff4f3d74),
      tertiaryFixed: Color(0xffffd8e7),
      onTertiaryFixed: Color(0xff380724),
      tertiaryFixedDim: Color(0xfffeb0d3),
      onTertiaryFixedVariant: Color(0xff6d3351),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
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
      secondary: Color(0xffe5d5ff),
      onSecondary: Color(0xff2d1a50),
      secondaryContainer: Color(0xff9b86c4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0e3),
      onTertiary: Color(0xff45122f),
      tertiaryContainer: Color(0xffc27b9c),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2ce),
      onError: Color(0xff481312),
      errorContainer: Color(0xffcb7b75),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd9dce5),
      outline: Color(0xffaeb2ba),
      outlineVariant: Color(0xff8c9098),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff4f3e76),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff16033c),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff3c2c63),
      secondaryFixed: Color(0xffebddff),
      onSecondaryFixed: Color(0xff18023b),
      secondaryFixedDim: Color(0xffd2bcfd),
      onSecondaryFixedVariant: Color(0xff3e2c62),
      tertiaryFixed: Color(0xffffd8e7),
      onTertiaryFixed: Color(0xff2a0019),
      tertiaryFixedDim: Color(0xfffeb0d3),
      onTertiaryFixedVariant: Color(0xff592340),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff43444a),
      surfaceContainerLowest: Color(0xff06070c),
      surfaceContainerLow: Color(0xff1c1d23),
      surfaceContainer: Color(0xff26282d),
      surfaceContainerHigh: Color(0xff313238),
      surfaceContainerHighest: Color(0xff3c3d43),
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
      secondary: Color(0xfff6ecff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffceb8f9),
      onSecondaryContainer: Color(0xff110031),
      tertiary: Color(0xffffebf1),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff9accf),
      onTertiaryContainer: Color(0xff1f0012),
      error: Color(0xffffecea),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea8),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf0f9),
      outlineVariant: Color(0xffbfc3cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff4f3e76),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd0bcfe),
      onPrimaryFixedVariant: Color(0xff16033c),
      secondaryFixed: Color(0xffebddff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd2bcfd),
      onSecondaryFixedVariant: Color(0xff18023b),
      tertiaryFixed: Color(0xffffd8e7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffeb0d3),
      onTertiaryFixedVariant: Color(0xff2a0019),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff4e5056),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e1f25),
      surfaceContainer: Color(0xff2f3036),
      surfaceContainerHigh: Color(0xff3a3b41),
      surfaceContainerHighest: Color(0xff45464c),
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
