import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/layouts/mobile_layout.dart';
import 'package:portfolio/features/homepage/presentation/layouts/tablet_layout.dart';
import 'package:portfolio/features/homepage/presentation/layouts/web_layout.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSizeBuilder(
        breakpoints: const BreakpointConfiguration(
          compact: 380,
          medium: 768,
          expanded: 1024,
          large: 1280,
        ),
        builder: (context, size) {
          if (size.isExpanded) {
            return const WebLayout();
          }

          if (size.isMedium) {
            return const TabletLayout();
          }

          return const MobileLayout();
        },
      ),
    );
  }
}
