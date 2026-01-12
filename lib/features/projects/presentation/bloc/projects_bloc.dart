import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/domain/usecases/project_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({
    required GetProjects getProjects,
    required GetProjectDetail getProjectDetail,
  }) : _getProjects = getProjects,
       _getProjectDetail = getProjectDetail,
       super(ProjectsInitialState()) {
    on<ProjectsListRequestedEvent>(_onListRequested);
    on<ProjectsDetailRequestedEvent>(_onDetailRequested);
  }

  final GetProjects _getProjects;
  final GetProjectDetail _getProjectDetail;

  Future<void> _onListRequested(
    ProjectsListRequestedEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(ProjectsLoadingState());
    final result = await _getProjects(
      GetProjectsParams(
        page: event.page,
        filter: event.filter,
        limit: event.limit,
      ),
    );
    result.fold(
      (failure) => emit(ProjectsFailureState(message: failure.message)),
      (projects) => emit(ProjectsListSuccessState(projects: projects)),
    );
  }

  Future<void> _onDetailRequested(
    ProjectsDetailRequestedEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(ProjectsLoadingState());
    final result = await _getProjectDetail(event.projectId);
    result.fold(
      (failure) => emit(ProjectsFailureState(message: failure.message)),
      (project) => emit(ProjectsDetailSuccessState(project: project)),
    );
  }
}
