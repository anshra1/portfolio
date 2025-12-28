// PATH: lib/features/projects/data/datasources/projects_remote_data_source.dart
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/data/models/project_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getProjects({
    required int page,
    required ProjectFilterModel filter,
    int? limit,
  });

  Future<ProjectModel> getProjectDetail(String projectId);
}
