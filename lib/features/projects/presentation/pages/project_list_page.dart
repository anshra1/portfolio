import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/app/app_router.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:portfolio/features/projects/presentation/widgets/project_list_widgets/project_list_grid_view.dart';
import 'package:portfolio/features/projects/presentation/widgets/project_list_widgets/project_list_header_visual.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
  void initState() {
    super.initState();
    // Trigger loading if not already loaded or if we want fresh data
    context.read<ProjectsBloc>().add(
      const ProjectsListRequestedEvent(
        page: 1,
        filter: ProjectFilter(),
        limit: 100,
      ), // Fetch all/more projects
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(RouteName.home),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProjectListHeaderVisual(),
              SizedBox(height: 48),
              ProjectListGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
