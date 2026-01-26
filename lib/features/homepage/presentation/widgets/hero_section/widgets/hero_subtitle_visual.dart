import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/widgets/responsive/responsive_width_wrapper.dart';

class HeroSubtitleVisual extends StatelessWidget {
  const HeroSubtitleVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidthWrapper(
      child: Text(
        'Building robust, intuitive, and beautiful cross-platform applications. Explore my journey from elegant UI to powerful backend integrations.',
        style: context.titleMedium.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
