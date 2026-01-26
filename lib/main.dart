import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/app/bootstrap.dart';
import 'package:portfolio/core/theme/theme.dart';

Future<void> main() async {
  await bootstrap(() => const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenSizeDetector(
      child: MaterialApp.router(
        title: 'Portfolio & Talker Demo',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
