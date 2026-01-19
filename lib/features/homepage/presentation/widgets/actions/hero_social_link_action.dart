import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density_extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSocialLinkAction extends StatelessWidget {
  const HeroSocialLinkAction({
    required this.icon,
    required this.url,
    required this.label,
    super.key,
  });
  final IconData icon;
  final String url;
  final String label;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => launchUrlString(url),
      icon: Icon(icon),
      tooltip: label,
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        hoverColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        padding: EdgeInsets.all(context.spacing.sm + context.spacing.xs),
      ),
      iconSize: context.sizes.iconMd,
    );
  }
}
