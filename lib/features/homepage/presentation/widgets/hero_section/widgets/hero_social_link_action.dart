import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSocialLinkAction extends StatefulWidget {
  const HeroSocialLinkAction({
    required this.icon,
    required this.url,
    required this.tooltipLabel,
    this.brandColor,
    super.key,
  });

  final IconData icon;
  final String url;
  final String tooltipLabel;
  final Color? brandColor;

  @override
  State<HeroSocialLinkAction> createState() => _HeroSocialLinkActionState();
}

class _HeroSocialLinkActionState extends State<HeroSocialLinkAction> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: KitIconButton(
        onPressed: () => launchUrlString(widget.url),
        icon: widget.icon,
        tooltip: widget.tooltipLabel,
        iconSize: 24, // Standard size per request
        backgroundColor: _isHovered ? widget.brandColor : Colors.transparent,
        color: _isHovered ? Colors.white : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
