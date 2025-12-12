import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
class NavigationTokens extends Equatable {
  final Color navigationBarBackgroundColor;
  final Color navigationBarForegroundColor;
  final Color navigationBarIndicatorColor;
  final Color navigationRailBackgroundColor;
  final Color navigationRailForegroundColor;
  final Color navigationRailIndicatorColor;
  final TextStyle navigationBarLabelTextStyle;
  final TextStyle navigationRailLabelTextStyle;

  const NavigationTokens({
    required this.navigationBarBackgroundColor,
    required this.navigationBarForegroundColor,
    required this.navigationBarIndicatorColor,
    required this.navigationRailBackgroundColor,
    required this.navigationRailForegroundColor,
    required this.navigationRailIndicatorColor,
    required this.navigationBarLabelTextStyle,
    required this.navigationRailLabelTextStyle,
  });

  NavigationTokens copyWith({
    Color? navigationBarBackgroundColor,
    Color? navigationBarForegroundColor,
    Color? navigationBarIndicatorColor,
    Color? navigationRailBackgroundColor,
    Color? navigationRailForegroundColor,
    Color? navigationRailIndicatorColor,
    TextStyle? navigationBarLabelTextStyle,
    TextStyle? navigationRailLabelTextStyle,
  }) {
    return NavigationTokens(
      navigationBarBackgroundColor: navigationBarBackgroundColor ?? this.navigationBarBackgroundColor,
      navigationBarForegroundColor: navigationBarForegroundColor ?? this.navigationBarForegroundColor,
      navigationBarIndicatorColor: navigationBarIndicatorColor ?? this.navigationBarIndicatorColor,
      navigationRailBackgroundColor: navigationRailBackgroundColor ?? this.navigationRailBackgroundColor,
      navigationRailForegroundColor: navigationRailForegroundColor ?? this.navigationRailForegroundColor,
      navigationRailIndicatorColor: navigationRailIndicatorColor ?? this.navigationRailIndicatorColor,
      navigationBarLabelTextStyle: navigationBarLabelTextStyle ?? this.navigationBarLabelTextStyle,
      navigationRailLabelTextStyle: navigationRailLabelTextStyle ?? this.navigationRailLabelTextStyle,
    );
  }

  @override
  List<Object?> get props => [
        navigationBarBackgroundColor,
        navigationBarForegroundColor,
        navigationBarIndicatorColor,
        navigationRailBackgroundColor,
        navigationRailForegroundColor,
        navigationRailIndicatorColor,
        navigationBarLabelTextStyle,
        navigationRailLabelTextStyle,
      ];

  @override
  String toString() {
    return 'NavigationTokens(navigationBarBackgroundColor: $navigationBarBackgroundColor, navigationBarForegroundColor: $navigationBarForegroundColor, navigationBarIndicatorColor: $navigationBarIndicatorColor, navigationRailBackgroundColor: $navigationRailBackgroundColor, navigationRailForegroundColor: $navigationRailForegroundColor, navigationRailIndicatorColor: $navigationRailIndicatorColor, navigationBarLabelTextStyle: $navigationBarLabelTextStyle, navigationRailLabelTextStyle: $navigationRailLabelTextStyle)';
  }
}
