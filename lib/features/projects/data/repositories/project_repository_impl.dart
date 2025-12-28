import 'package:dartz/dartz.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  ProjectRepositoryImpl({required this.remoteDataSource});
  final ProjectsRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<Project>> getProjects({
    required int page,
    required ProjectFilter filter,
    int? limit,
  }) async {
    try {
      final filterModel = ProjectFilterModel.fromEntity(filter);
      final projectModels = await remoteDataSource.getProjects(
        page: page,
        filter: filterModel,
        limit: limit,
      );
      final projects = projectModels.map((e) => e.toEntity()).toList();
      return Right(projects);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.userMessage,
          title: e.title,
          code: e.code,
          context: e.context ?? {},
          priority: e.priority,
          isRecoverable: e.isRecoverable,
        ),
      );
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<Project> getProjectDetail(String projectId) async {
    try {
      final projectModel = await remoteDataSource.getProjectDetail(projectId);
      return Right(projectModel.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.userMessage,
          title: e.title,
          code: e.code,
          context: e.context ?? {},
          priority: e.priority,
          isRecoverable: e.isRecoverable,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
