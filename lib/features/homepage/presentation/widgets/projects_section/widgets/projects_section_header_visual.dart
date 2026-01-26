import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class ProjectsSectionHeaderVisual extends StatelessWidget {
  const ProjectsSectionHeaderVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Flutter Creations',
      style: context.headlineLarge.copyWith(
        fontWeight: FontWeight.w900,
        //   color: Theme.of(context).colorScheme.onSurface,
        letterSpacing: -0.5,
      ),
    );
  }
}
