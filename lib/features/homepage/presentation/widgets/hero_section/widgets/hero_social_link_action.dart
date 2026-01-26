import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
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
    return KitIconButton(
      onPressed: () => launchUrlString(url),
      icon: Icon(icon),
      tooltip: label,
      iconSize: 24, // Standard size per request
    );
  }
}
