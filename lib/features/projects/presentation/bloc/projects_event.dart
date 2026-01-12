part of 'projects_bloc.dart';

sealed class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

final class ProjectsListRequestedEvent extends ProjectsEvent {
  const ProjectsListRequestedEvent({
    required this.page,
    required this.filter,
    this.limit,
  });

  final int page;
  final ProjectFilter filter;
  final int? limit;

  @override
  List<Object?> get props => [page, filter, limit];
}

final class ProjectsDetailRequestedEvent extends ProjectsEvent {
  const ProjectsDetailRequestedEvent(this.projectId);

  final String projectId;

  @override
  List<Object?> get props => [projectId];
}
