import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/home_page_mobile.dart';
import 'package:portfolio/features/homepage/home_page_tablet.dart';
import 'package:portfolio/features/homepage/home_page_web.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSizeBuilder(
      builder: (context, size) {
        if (size.isDesktop) {
          return const HomePageWeb();
        }

        if (size.isTablet) {
          return const HomePageTablet();
        }

        return const HomePageMobile();
      },
    );
  }
}
