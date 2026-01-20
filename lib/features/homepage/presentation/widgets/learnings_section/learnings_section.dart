import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/density/density.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_header_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/learnings_view.dart';
import 'package:portfolio/features/homepage/presentation/widgets/learnings_section/view_all_learnings_action.dart';

class LearningsSection extends StatelessWidget {
  const LearningsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24, // px-4 sm:px-6 lg:px-8 roughly
        vertical: 64, // py-16 sm:py-24
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LearningsHeaderVisual(),
              SizedBox(height: context.spacing.xl),
              const LearningsView(),
              SizedBox(height: context.spacing.xl),
              const ViewAllLearningsAction(),
            ],
          ),
        ),
      ),
    );
  }
}
