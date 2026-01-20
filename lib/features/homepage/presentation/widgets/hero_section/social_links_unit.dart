import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_context.dart';
import 'package:portfolio/features/homepage/presentation/widgets/hero_section/hero_social_link_action.dart';

class SocialLinksUnit extends StatelessWidget {
  const SocialLinksUnit({super.key});

  @override
  Widget build(BuildContext context) {
    // Icons are using standard Material Icons as placeholders for generic social icons
    // In a real app, use font_awesome_flutter or custom SVGs
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const HeroSocialLinkAction(
          icon: Icons.code, // GitHub placeholder
          url: 'https://github.com',
          label: 'GitHub',
        ),
        SizedBox(width: context.spacing.lg),
        const HeroSocialLinkAction(
          icon: Icons.work, // LinkedIn placeholder
          url: 'https://linkedin.com',
          label: 'LinkedIn',
        ),
        SizedBox(width: context.spacing.lg),
        const HeroSocialLinkAction(
          icon: Icons.article, // Medium placeholder
          url: 'https://medium.com',
          label: 'Medium',
        ),
      ],
    );
  }
}
