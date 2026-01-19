import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';
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
