import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_primary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_secondary_action.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/social_links_unit.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_title_visual.dart';

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
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.xl,
              vertical: context.spacing.xxl + context.spacing.md,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    SizedBox(height: context.spacing.xl + context.spacing.sm),
                    const HeroTitleVisual(),
                    SizedBox(height: context.spacing.lg),
                    const HeroSubtitleVisual(),
                    SizedBox(height: context.spacing.xl + context.spacing.sm),
                    // Actions in Row for tablet
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeroPrimaryAction(onPressed: () {}),
                        SizedBox(width: context.spacing.md),
                        HeroSecondaryAction(onPressed: () {}),
                      ],
                    ),
                    SizedBox(height: context.spacing.xl),
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
