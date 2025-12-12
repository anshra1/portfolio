import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class ButtonTokens extends Equatable {
  final Color elevatedButtonBackgroundColor;
  final Color elevatedButtonForegroundColor;
  final Color elevatedButtonDisabledBackgroundColor;
  final Color elevatedButtonDisabledForegroundColor;
  final Color outlinedButtonBorderColor;
  final Color outlinedButtonForegroundColor;
  final Color textButtonForegroundColor;
  final TextStyle textStyle;

  const ButtonTokens({
    required this.elevatedButtonBackgroundColor,
    required this.elevatedButtonForegroundColor,
    required this.elevatedButtonDisabledBackgroundColor,
    required this.elevatedButtonDisabledForegroundColor,
    required this.outlinedButtonBorderColor,
    required this.outlinedButtonForegroundColor,
    required this.textButtonForegroundColor,
    required this.textStyle,
  });

  ButtonTokens copyWith({
    Color? elevatedButtonBackgroundColor,
    Color? elevatedButtonForegroundColor,
    Color? elevatedButtonDisabledBackgroundColor,
    Color? elevatedButtonDisabledForegroundColor,
    Color? outlinedButtonBorderColor,
    Color? outlinedButtonForegroundColor,
    Color? textButtonForegroundColor,
    TextStyle? textStyle,
  }) {
    return ButtonTokens(
      elevatedButtonBackgroundColor: elevatedButtonBackgroundColor ?? this.elevatedButtonBackgroundColor,
      elevatedButtonForegroundColor: elevatedButtonForegroundColor ?? this.elevatedButtonForegroundColor,
      elevatedButtonDisabledBackgroundColor: elevatedButtonDisabledBackgroundColor ?? this.elevatedButtonDisabledBackgroundColor,
      elevatedButtonDisabledForegroundColor: elevatedButtonDisabledForegroundColor ?? this.elevatedButtonDisabledForegroundColor,
      outlinedButtonBorderColor: outlinedButtonBorderColor ?? this.outlinedButtonBorderColor,
      outlinedButtonForegroundColor: outlinedButtonForegroundColor ?? this.outlinedButtonForegroundColor,
      textButtonForegroundColor: textButtonForegroundColor ?? this.textButtonForegroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  List<Object?> get props => [
        elevatedButtonBackgroundColor,
        elevatedButtonForegroundColor,
        elevatedButtonDisabledBackgroundColor,
        elevatedButtonDisabledForegroundColor,
        outlinedButtonBorderColor,
        outlinedButtonForegroundColor,
        textButtonForegroundColor,
        textStyle,
      ];

  @override
  String toString() {
    return 'ButtonTokens(elevatedButtonBackgroundColor: $elevatedButtonBackgroundColor, elevatedButtonForegroundColor: $elevatedButtonForegroundColor, elevatedButtonDisabledBackgroundColor: $elevatedButtonDisabledBackgroundColor, elevatedButtonDisabledForegroundColor: $elevatedButtonDisabledForegroundColor, outlinedButtonBorderColor: $outlinedButtonBorderColor, outlinedButtonForegroundColor: $outlinedButtonForegroundColor, textButtonForegroundColor: $textButtonForegroundColor, textStyle: $textStyle)';
  }
}
