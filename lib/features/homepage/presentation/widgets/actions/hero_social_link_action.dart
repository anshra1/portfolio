import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSocialLinkAction extends StatelessWidget {
  final IconData icon;
  final String url;
  final String label;

  const HeroSocialLinkAction({
    super.key,
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => launchUrlString(url),
      icon: Icon(icon),
      tooltip: label,
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        hoverColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        padding: const EdgeInsets.all(12),
      ),
      iconSize: 24,
    );
  }
}
