import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class LearningsHeaderVisual extends StatelessWidget {
  const LearningsHeaderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Learning Journey',
          // Changed from Theme.of(context).textTheme... to context extension
          style: context.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Snippets from my daily dev log. I document the advanced techniques, '
          'specific bug fixes, and architectural patterns I discover while building applications.',
          // Changed from Theme.of(context).textTheme... to context extension
          style: context.bodyLarge.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
