import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class AppBarTokens extends Equatable {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color shadowColor;
  final Color surfaceTintColor;
  final TextStyle titleTextStyle;

  const AppBarTokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shadowColor,
    required this.surfaceTintColor,
    required this.titleTextStyle,
  });

  AppBarTokens copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    TextStyle? titleTextStyle,
  }) {
    return AppBarTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }

  @override
  List<Object?> get props => [backgroundColor, foregroundColor, shadowColor, surfaceTintColor, titleTextStyle];

  @override
  String toString() {
    return 'AppBarTokens(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, shadowColor: $shadowColor, surfaceTintColor: $surfaceTintColor, titleTextStyle: $titleTextStyle)';
  }
}
