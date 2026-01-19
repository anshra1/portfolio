import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/widgets/actions/hero_primary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/actions/hero_secondary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/units/social_links_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/visuals/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/visuals/hero_title_visual.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 48,
            ),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const HeroTitleVisual(),
                const SizedBox(height: 20),
                const HeroSubtitleVisual(),
                const SizedBox(height: 32),
                // Actions in Column for mobile
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroPrimaryAction(onPressed: () {}),
                    const SizedBox(height: 16),
                    HeroSecondaryAction(onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 24),
                const SocialLinksUnit(),
              ],
            ),
          ),
          // TODO: Add ProjectsSection
          // TODO: Add LearningsSection
          // TODO: Add AboutSection
          // TODO: Add ExpertiseSection
          // TODO: Add SiteFooter
        ],
      ),
    );
  }
}
