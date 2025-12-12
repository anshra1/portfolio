import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class ChipTokens extends Equatable {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color selectedColor;
  final Color disabledColor;
  final TextStyle labelStyle;

  const ChipTokens({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.selectedColor,
    required this.disabledColor,
    required this.labelStyle,
  });

  ChipTokens copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? selectedColor,
    Color? disabledColor,
    TextStyle? labelStyle,
  }) {
    return ChipTokens(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      disabledColor: disabledColor ?? this.disabledColor,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }

  @override
  List<Object?> get props => [backgroundColor, foregroundColor, selectedColor, disabledColor, labelStyle];

  @override
  String toString() {
    return 'ChipTokens(backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, selectedColor: $selectedColor, disabledColor: $disabledColor, labelStyle: $labelStyle)';
  }
}
