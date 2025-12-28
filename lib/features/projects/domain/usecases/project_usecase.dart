import 'package:equatable/equatable.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/common/usecase.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';

class GetProjectsParams extends Equatable {
  const GetProjectsParams({
    required this.page,
    required this.filter,
    this.limit,
  });

  final int page;
  final int? limit;
  final ProjectFilter filter;

  @override
  List<Object?> get props => [page, limit, filter];
}

class GetProjects
    extends FutureUseCaseWithParams<List<Project>, GetProjectsParams> {
  const GetProjects(this._repository);

  final ProjectRepository _repository;

  @override
  ResultFuture<List<Project>> call(GetProjectsParams params) {
    return _repository.getProjects(
      page: params.page,
      filter: params.filter,
      limit: params.limit,
    );
  }
}

class GetProjectDetail extends FutureUseCaseWithParams<Project, String> {
  const GetProjectDetail(this._repository);

  final ProjectRepository _repository;

  @override
  ResultFuture<Project> call(String params) {
    return _repository.getProjectDetail(params);
  }
}