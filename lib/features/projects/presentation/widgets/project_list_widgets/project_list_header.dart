import 'package:flutter/material.dart';

class ProjectListHeaderVisual extends StatelessWidget {
  const ProjectListHeaderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '© 2025 Flutter Developer Portfolio. All rights reserved.',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }
}
