import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';

abstract interface class ProjectRepository {
  ResultFuture<List<Project>> getProjects({required ProjectFilter filter});
  ResultFuture<Project> getProjectDetail(String projectId);
}
