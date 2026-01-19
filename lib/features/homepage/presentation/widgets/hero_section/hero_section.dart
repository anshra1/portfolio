import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_title_visual.dart';
// import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_actions_layout.dart'; // Missing file
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/social_links_unit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24, // px-4 sm:px-6 lg:px-8 roughly
        vertical: 64, // py-16 sm:py-24
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152), // max-w-6xl
          child: const Column(
            children: [
              SizedBox(height: 40), // pt-10
              HeroTitleVisual(),
              SizedBox(height: 24), // mt-6
              HeroSubtitleVisual(),
              SizedBox(height: 40), // mt-10
              // HomepageHeroActionsLayout(), // Missing widget
              SizedBox(height: 32), // mt-8
              SocialLinksUnit(),
            ],
          ),
        ),
      ),
    );
  }
}
