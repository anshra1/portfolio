import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class CardTokens extends Equatable {
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final Color surfaceTintColor;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  const CardTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.surfaceTintColor,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
  });

  CardTokens copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) {
    return CardTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    );
  }

  @override
  List<Object?> get props => [backgroundColor, borderColor, shadowColor, surfaceTintColor, titleTextStyle, subtitleTextStyle];

  @override
  String toString() {
    return 'CardTokens(backgroundColor: $backgroundColor, borderColor: $borderColor, shadowColor: $shadowColor, surfaceTintColor: $surfaceTintColor, titleTextStyle: $titleTextStyle, subtitleTextStyle: $subtitleTextStyle)';
  }
}
