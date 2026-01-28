import 'package:flutter/material.dart';
import 'package:portfolio/core/ds/density_context.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/hero_secondary_action.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/hero_subtitle_visual.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/hero_title_visual.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/hero_primary_action.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/social_links_unit.dart';
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          LayoutBuilder(
            builder: (context, constraints) {
              // Mobile breakpoint < 600px (standard sm)
              final isMobile = MediaQuery.sizeOf(context).width < 600;

              if (isMobile) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroPrimaryAction(onPressed: () {}),
                    SizedBox(height: context.spacing.lg),
                    HeroSecondaryAction(onPressed: () {}),
                  ],
                );
              }

              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroPrimaryAction(onPressed: () {}),
                    HeroSecondaryAction(onPressed: () {}),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: context.spacing.lg),
          const SocialLinksUnit(),
        ],
      ),
    );
  }
}
