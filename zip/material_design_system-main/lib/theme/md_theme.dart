import 'package:flutter/material.dart';
import 'package:material_design_system/theme/md_theme_token.dart';

class MdTheme extends StatelessWidget {
  const MdTheme({required this.data, required this.child, super.key});

  final MdThemeToken data;
  final Widget child;

  static MdThemeToken of(BuildContext context, {bool listen = true}) {
    final provider = maybeOf(context, listen: listen);
    if (provider == null) {
      throw FlutterError('''
        AppTheme.of() called with a context that does not contain a AppTheme.\n
        No AppTheme ancestor could be found starting from the context that was passed to AppTheme.of().
        This can happen because you do not have a AppTheme widget (which introduces a AppTheme),
        or it can happen if the context you use comes from a widget above this widget.\n
        The context used was: $context''');
    }
    return provider;
  }

  static MdThemeToken? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<AppInheritedTheme>()?.themeData;
    }
    final provider = context
        .getElementForInheritedWidgetOfExactType<AppInheritedTheme>()
        ?.widget;

    return (provider as AppInheritedTheme?)?.themeData;
  }

  @override
  Widget build(BuildContext context) {
    return AppInheritedTheme(themeData: data, child: child);
  }
}

class AppInheritedTheme extends InheritedTheme {
  const AppInheritedTheme({required this.themeData, required super.child, super.key});

  final MdThemeToken themeData;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MdTheme(data: themeData, child: child);
  }

  @override
  bool updateShouldNotify(AppInheritedTheme oldWidget) =>
      themeData != oldWidget.themeData;
}
