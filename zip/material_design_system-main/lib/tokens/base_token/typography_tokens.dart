import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:material_design_system/src/responsive/breakpoint_configuration.dart';
import 'package:material_design_system/src/responsive/font_scaling_configuration.dart';
import 'package:material_design_system/tokens/base_token/text_style_token.dart';
import 'package:material_design_system/tokens/style_token.dart';

@immutable
class TypographyTokens extends Equatable {
   TypographyTokens({
    StyleToken? style,
    TextStyleToken? displayLarge,
    TextStyleToken? displayMedium,
    TextStyleToken? displaySmall,
    TextStyleToken? headlineLarge,
    TextStyleToken? headlineMedium,
    TextStyleToken? headlineSmall,
    TextStyleToken? titleLarge,
    TextStyleToken? titleMedium,
    TextStyleToken? titleSmall,
    TextStyleToken? bodyLarge,
    TextStyleToken? bodyMedium,
    TextStyleToken? bodySmall,
    TextStyleToken? labelLarge,
    TextStyleToken? labelMedium,
    TextStyleToken? labelSmall,
    this.breakpoints = const BreakpointConfiguration(),
    this.fontScaling = const FontScalingConfiguration(),
  }) : displayLarge = displayLarge ??  TextStyleToken(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    displayMedium = displayMedium ?? const TextStyleToken(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    displaySmall = displaySmall ?? const TextStyleToken(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    headlineLarge = headlineLarge ?? const TextStyleToken(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    headlineMedium = headlineMedium ?? const TextStyleToken(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.3,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    headlineSmall = headlineSmall ?? const TextStyleToken(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    titleLarge = titleLarge ?? const TextStyleToken(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.27,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    titleMedium = titleMedium ?? const TextStyleToken(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.5,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    titleSmall = titleSmall ?? const TextStyleToken(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    bodyLarge = bodyLarge ?? const TextStyleToken(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    bodyMedium = bodyMedium ?? const TextStyleToken(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    bodySmall = bodySmall ?? const TextStyleToken(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    labelLarge = labelLarge ?? const TextStyleToken(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    labelMedium = labelMedium ?? const TextStyleToken(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
    ).scale(style?.fontSizeMultiplier ?? 1.0),
    labelSmall = labelSmall ?? const TextStyleToken(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
    ).scale(style?.fontSizeMultiplier ?? 1.0);
  final TextStyleToken displayLarge;
  final TextStyleToken displayMedium;
  final TextStyleToken displaySmall;
  final TextStyleToken headlineLarge;
  final TextStyleToken headlineMedium;
  final TextStyleToken headlineSmall;
  final TextStyleToken titleLarge;
  final TextStyleToken titleMedium;
  final TextStyleToken titleSmall;
  final TextStyleToken bodyLarge;
  final TextStyleToken bodyMedium;
  final TextStyleToken bodySmall;
  final TextStyleToken labelLarge;
  final TextStyleToken labelMedium;
  final TextStyleToken labelSmall;

  final BreakpointConfiguration breakpoints;
  final FontScalingConfiguration fontScaling;

  TextStyle getDisplayLarge([BuildContext? context]) =>
      displayLarge(context, breakpoints, fontScaling);
  TextStyle getDisplayMedium([BuildContext? context]) =>
      displayMedium(context, breakpoints, fontScaling);
  TextStyle getDisplaySmall([BuildContext? context]) =>
      displaySmall(context, breakpoints, fontScaling);
  TextStyle getHeadlineLarge([BuildContext? context]) =>
      headlineLarge(context, breakpoints, fontScaling);
  TextStyle getHeadlineMedium([BuildContext? context]) =>
      headlineMedium(context, breakpoints, fontScaling);
  TextStyle getHeadlineSmall([BuildContext? context]) =>
      headlineSmall(context, breakpoints, fontScaling);
  TextStyle getTitleLarge([BuildContext? context]) =>
      titleLarge(context, breakpoints, fontScaling);
  TextStyle getTitleMedium([BuildContext? context]) =>
      titleMedium(context, breakpoints, fontScaling);
  TextStyle getTitleSmall([BuildContext? context]) =>
      titleSmall(context, breakpoints, fontScaling);
  TextStyle getBodyLarge([BuildContext? context]) =>
      bodyLarge(context, breakpoints, fontScaling);
  TextStyle getBodyMedium([BuildContext? context]) =>
      bodyMedium(context, breakpoints, fontScaling);
  TextStyle getBodySmall([BuildContext? context]) =>
      bodySmall(context, breakpoints, fontScaling);
  TextStyle getLabelLarge([BuildContext? context]) =>
      labelLarge(context, breakpoints, fontScaling);
  TextStyle getLabelMedium([BuildContext? context]) =>
      labelMedium(context, breakpoints, fontScaling);
  TextStyle getLabelSmall([BuildContext? context]) =>
      labelSmall(context, breakpoints, fontScaling);

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: getDisplayLarge(),
      displayMedium: getDisplayMedium(),
      displaySmall: getDisplaySmall(),
      headlineLarge: getHeadlineLarge(),
      headlineMedium: getHeadlineMedium(),
      headlineSmall: getHeadlineSmall(),
      titleLarge: getTitleLarge(),
      titleMedium: getTitleMedium(),
      titleSmall: getTitleSmall(),
      bodyLarge: getBodyLarge(),
      bodyMedium: getBodyMedium(),
      bodySmall: getBodySmall(),
      labelLarge: getLabelLarge(),
      labelMedium: getLabelMedium(),
      labelSmall: getLabelSmall(),
    );
  }

  TypographyTokens copyWith({
    TextStyleToken? displayLarge,
    TextStyleToken? displayMedium,
    TextStyleToken? displaySmall,
    TextStyleToken? headlineLarge,
    TextStyleToken? headlineMedium,
    TextStyleToken? headlineSmall,
    TextStyleToken? titleLarge,
    TextStyleToken? titleMedium,
    TextStyleToken? titleSmall,
    TextStyleToken? bodyLarge,
    TextStyleToken? bodyMedium,
    TextStyleToken? bodySmall,
    TextStyleToken? labelLarge,
    TextStyleToken? labelMedium,
    TextStyleToken? labelSmall,
    BreakpointConfiguration? breakpoints,
    FontScalingConfiguration? fontScaling,
  }) {
    return TypographyTokens(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      breakpoints: breakpoints ?? this.breakpoints,
      fontScaling: fontScaling ?? this.fontScaling,
    );
  }

  @override
  List<Object?> get props => [
    displayLarge,
    displayMedium,
    displaySmall,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    titleLarge,
    titleMedium,
    titleSmall,
    bodyLarge,
    bodyMedium,
    bodySmall,
    labelLarge,
    labelMedium,
    labelSmall,
    breakpoints,
    fontScaling,
  ];
}
