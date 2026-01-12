part of 'projects_bloc.dart';

sealed class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => [];
}

final class ProjectsInitialState extends ProjectsState {}

final class ProjectsLoadingState extends ProjectsState {}

final class ProjectsListSuccessState extends ProjectsState {
  const ProjectsListSuccessState({
    required this.projects,
  });

  final List<Project> projects;

  @override
  List<Object?> get props => [projects];
}

final class ProjectsDetailSuccessState extends ProjectsState {
  const ProjectsDetailSuccessState({
    required this.project,
  });

  final Project project;

  @override
  List<Object?> get props => [project];
}

final class ProjectsFailureState extends ProjectsState {
  const ProjectsFailureState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}
