import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/core/presentation/widgets/layouts/responsive_grid_layout.dart';
import 'package:portfolio/features/homepage/presentation/mappers/project_mapper.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/projects_section/widgets/project_card_unit.dart';
import 'package:portfolio/features/homepage/presentation/pages/home/sections/projects_section/skeleton/projects_skeleton_visual.dart';
import 'package:portfolio/features/projects/presentation/bloc/projects_bloc.dart';

class ProjectListGridView extends StatelessWidget {
  const ProjectListGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return switch (state) {
          ProjectsInitialState() ||
          ProjectsLoadingState() => const ProjectsSkeletonVisual(),
          ProjectsListSuccessState(:final projects) => ResponsiveGridLayout(
            limitOnMobile: false, // Show all projects vertically on mobile
            children: projects
                .map(
                  (p) => GestureDetector(
                    onTap: () => context.pushNamed(
                      RouteName.projectDetailPage,
                      extra: p.id,
                    ),
                    child: ProjectCardUnit(
                      project: mapProjectToDisplayModel(p),
                      onDownloadPressed: () => context.pushNamed(
                        RouteName.projectDetailPage,
                        extra: p.id,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ProjectsFailureState(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Text(
                'Error loading projects: $message',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
