import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class DialogTokens extends Equatable {
  final Color backgroundColor;
  final Color surfaceTintColor;
  final TextStyle titleTextStyle;
  final TextStyle contentTextStyle;

  const DialogTokens({
    required this.backgroundColor,
    required this.surfaceTintColor,
    required this.titleTextStyle,
    required this.contentTextStyle,
  });

  DialogTokens copyWith({
    Color? backgroundColor,
    Color? surfaceTintColor,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return DialogTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  List<Object?> get props => [backgroundColor, surfaceTintColor, titleTextStyle, contentTextStyle];

  @override
  String toString() {
    return 'DialogTokens(backgroundColor: $backgroundColor, surfaceTintColor: $surfaceTintColor, titleTextStyle: $titleTextStyle, contentTextStyle: $contentTextStyle)';
  }
}
