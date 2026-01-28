import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/ds/density_context.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/hero_section/widgets/hero_social_link_action.dart';

class SocialLinksUnit extends StatelessWidget {
  const SocialLinksUnit({super.key});

  @override
  Widget build(BuildContext context) {
    // Icons are using FontAwesome Icons
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const HeroSocialLinkAction(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com',
          tooltipLabel: 'GitHub',
          brandColor: Colors.black,
        ),
        SizedBox(width: context.spacing.md),
        const HeroSocialLinkAction(
          icon: FontAwesomeIcons.linkedin,
          url: 'https://linkedin.com',
          tooltipLabel: 'LinkedIn',
          brandColor: Color(0xFF0077B5),
        ),
        SizedBox(width: context.spacing.md),
        const HeroSocialLinkAction(
          icon: FontAwesomeIcons.medium,
          url: 'https://medium.com',
          tooltipLabel: 'Medium',
          brandColor: Colors.black,
        ),
      ],
    );
  }
}
