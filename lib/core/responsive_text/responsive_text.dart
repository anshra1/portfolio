import 'package:flutter/material.dart';
import 'package:portfolio/core/responsive_text/responsive_layout.dart';

/// A wrapper around [Text] that automatically scales its font size
/// based on the current screen width.
///
/// Usage:
/// ```dart
/// ResponsiveText(
///   'Hello World',
///   style: TextStyle(fontSize: 16), // Mobile size
/// )
/// // On Tablet: ~20px
/// // On Desktop: ~24px
/// ```
class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final scaleFactor = ResponsiveScaler.getScaleFactor(width);

    final effectiveStyle = style ?? DefaultTextStyle.of(context).style;
    final scaledFontSize = (effectiveStyle.fontSize ?? 14) * scaleFactor;

    return Text(
      data,
      style: effectiveStyle.copyWith(fontSize: scaledFontSize),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
