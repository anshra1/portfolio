import 'package:flutter/material.dart';
import 'package:portfolio/core/widgets/responsive/responsive_width_wrapper.dart';

class ProjectListHeaderVisual extends StatelessWidget {
  const ProjectListHeaderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'My Project ',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(
                text: 'Archive',
                style: TextStyle(color: theme.primaryColor),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ResponsiveWidthWrapper(
          child: SelectableText(
            'A complete collection of my mobile applications, open-source contributions, and experimental proofs-of-concept.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
