import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/app/bootstrap.dart';
import 'package:portfolio/core/theme/app_theme.dart';

Future<void> main() async {
  await bootstrap(() => const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = ThemeMode
  .light;

  @override
  Widget build(BuildContext context) {
    return ScreenSizeDetector(
      child: Builder(
        builder: (context) {
          final responsiveTokens = ResponsiveTokens.m3();
          final textTheme = responsiveTokens.toTextTheme(context);

          return MaterialApp.router(
            title: 'Portfolio & Talker Demo',
            themeMode: _themeMode,
            theme: AppTheme.light.copyWith(textTheme: textTheme),
            darkTheme: AppTheme.dark.copyWith(textTheme: textTheme),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
