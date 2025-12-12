import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class FabTokens extends Equatable {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color focusColor;
  final Color hoverColor;
  final Color splashColor;

  const FabTokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.focusColor,
    required this.hoverColor,
    required this.splashColor,
  });

  FabTokens copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? splashColor,
  }) {
    return FabTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      splashColor: splashColor ?? this.splashColor,
    );
  }

  @override
  List<Object?> get props => [backgroundColor, foregroundColor, focusColor, hoverColor, splashColor];

  @override
  String toString() {
    return 'FabTokens(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, focusColor: $focusColor, hoverColor: $hoverColor, splashColor: $splashColor)';
  }
}
