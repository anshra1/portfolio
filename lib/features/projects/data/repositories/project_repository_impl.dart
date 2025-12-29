// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:portfolio/core/common/enums.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/domain/entities/project.dart';
import 'package:portfolio/features/projects/domain/entities/project_filter.dart';
import 'package:portfolio/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl(this._remoteDataSource);

  final ProjectsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Project>> getProjects({
    required int page,
    required ProjectFilter filter,
    int? limit,
  }) async {
    try {
      // Logic Injection: Retrieve the complete dataset for in-memory processing.
      final allModels = await _remoteDataSource.getProjects(
        page: 1,
        filter: const ProjectFilterModel(),
        limit: 1000,
      );

      var projects = allModels.map((e) => e.toEntity()).toList();

      // 1. Apply Search Filtering
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        final query = filter.searchQuery!.toLowerCase();
        projects = projects.where((p) {
          return p.title.toLowerCase().contains(query) ||
              p.tagline.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query);
        }).toList();
      }

      // 2. Apply Technology Filtering
      if (filter.technology != null && filter.technology!.isNotEmpty) {
        projects = projects.where((p) {
          return p.technologies.any(
            (t) => t.toLowerCase() == filter.technology!.toLowerCase(),
          );
        }).toList();
      }

      // 3. Apply Ranked Sorting (Fundamental Architectural Logic)
      // Primary: Display Tier (Hero > Showcase > Standard)
      // Secondary: Date (Newest > Oldest)
      projects.sort((a, b) {
        final tierResult = a.displayTier.index.compareTo(b.displayTier.index);
        if (tierResult != 0) {
          return tierResult;
        }

        if (filter.sortOrder == SortOrder.oldest) {
          return a.publishedAt.compareTo(b.publishedAt);
        }

        return b.publishedAt.compareTo(a.publishedAt);
      });

      // 4. Apply Pagination
      final effectiveLimit = limit ?? 10;
      final startIndex = (page - 1) * effectiveLimit;

      if (startIndex >= projects.length) {
        return const Right([]);
      }

      final endIndex = (startIndex + effectiveLimit) > projects.length
          ? projects.length
          : (startIndex + effectiveLimit);

      return Right(projects.sublist(startIndex, endIndex));
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<Project> getProjectDetail(String projectId) async {
    try {
      final model = await _remoteDataSource.getProjectDetail(projectId);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }
}
