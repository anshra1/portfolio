import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class TextFieldTokens extends Equatable {
  final Color backgroundColor;
  final Color cursorColor;
  final Color selectionColor;
  final Color selectionHandleColor;
  final Color focusColor;
  final Color hoverColor;
  final TextStyle textStyle;
  final TextStyle labelStyle;

  const TextFieldTokens({
    required this.backgroundColor,
    required this.cursorColor,
    required this.selectionColor,
    required this.selectionHandleColor,
    required this.focusColor,
    required this.hoverColor,
    required this.textStyle,
    required this.labelStyle,
  });

  TextFieldTokens copyWith({
    Color? backgroundColor,
    Color? cursorColor,
    Color? selectionColor,
    Color? selectionHandleColor,
    Color? focusColor,
    Color? hoverColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
  }) {
    return TextFieldTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionColor: selectionColor ?? this.selectionColor,
      selectionHandleColor: selectionHandleColor ?? this.selectionHandleColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }

  @override
  List<Object?> get props => [
        backgroundColor,
        cursorColor,
        selectionColor,
        selectionHandleColor,
        focusColor,
        hoverColor,
        textStyle,
        labelStyle,
      ];

  @override
  String toString() {
    return 'TextFieldTokens(backgroundColor: $backgroundColor, cursorColor: $cursorColor, selectionColor: $selectionColor, selectionHandleColor: $selectionHandleColor, focusColor: $focusColor, hoverColor: $hoverColor, textStyle: $textStyle, labelStyle: $labelStyle)';
  }
}
