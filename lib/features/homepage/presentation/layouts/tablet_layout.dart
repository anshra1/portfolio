import 'package:flutter/material.dart';
import 'package:portfolio/features/homepage/presentation/widgets/actions/hero_primary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/actions/hero_secondary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/units/social_links_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/visuals/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/visuals/hero_title_visual.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 64,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const HeroTitleVisual(),
                    const SizedBox(height: 24),
                    const HeroSubtitleVisual(),
                    const SizedBox(height: 40),
                    // Actions in Row for tablet
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeroPrimaryAction(onPressed: () {}),
                        const SizedBox(width: 16),
                        HeroSecondaryAction(onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const SocialLinksUnit(),
                  ],
                ),
              ),
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
