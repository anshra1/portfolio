import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_primary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_secondary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_title_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/social_links_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/projects_section.dart';

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
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.md,
              vertical: context.spacing.xxl,
            ),
            child: Column(
              children: [
                SizedBox(height: context.spacing.xl),
                const HeroTitleVisual(),
                SizedBox(height: context.spacing.lg),
                const HeroSubtitleVisual(),
                SizedBox(height: context.spacing.xl),
                // Actions in Column for mobile
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroPrimaryAction(onPressed: () {}),
                    SizedBox(height: context.spacing.md),
                    HeroSecondaryAction(onPressed: () {}),
                  ],
                ),
                SizedBox(height: context.spacing.lg),
                const SocialLinksUnit(),
              ],
            ),
          ),
          const ProjectsSection(),
          // TODO: Add LearningsSection
          // TODO: Add AboutSection
          // TODO: Add ExpertiseSection
          // TODO: Add SiteFooter
        ],
      ),
    );
  }
}
