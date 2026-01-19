import 'package:flutter/material.dart';

class HeroSubtitleVisual extends StatelessWidget {
  const HeroSubtitleVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      'Building robust, intuitive, and beautiful cross-platform applications. Explore my journey from elegant UI to powerful backend integrations.',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
