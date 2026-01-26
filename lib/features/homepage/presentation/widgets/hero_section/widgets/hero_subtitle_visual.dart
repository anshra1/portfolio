import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class HeroSubtitleVisual extends StatelessWidget {
  const HeroSubtitleVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: context.titleMedium.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        children: const [
          TextSpan(text: 'Building robust, intuitive, and beautiful '),
          TextSpan(
            text: 'cross-platform applications',
            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '. Explore my journey...'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
