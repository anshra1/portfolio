import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/widgets/projects_section_header_visual.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/widgets/projects_view.dart';
import 'package:portfolio/features/homepage/presentation/widgets/projects_section/widgets/view_more_projects_action.dart';

/// Section container that composes the projects header, view, and action.
/// Does NOT listen to state — delegates to [ProjectsView].
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1152),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProjectsSectionHeaderVisual(),
              const SizedBox(height: 32),
              const ProjectsView(),
              const SizedBox(height: 16),
              ViewMoreProjectsAction(
                onPressed: () async {
                  await context.pushNamed(RouteName.projectListPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
