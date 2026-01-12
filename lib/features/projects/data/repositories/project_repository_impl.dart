//
// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/common/enums.dart';
import 'package:portfolio/core/common/typedefs.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:portfolio/features/projects/data/models/project_filter_model.dart';
import 'package:portfolio/features/projects/domain/entities/display_tier.dart';
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
    // Step 1: Sanitize Inputs
    final cleanPage = max(1, page);
    // If limit is null or <= 0, set limit to 6 (Default).
    final cleanLimit = (limit != null && limit > 0)
        ? limit
        : AppConstants.defaultProjectPageSize;
    final cleanQuery = filter.searchQuery?.trim().toLowerCase() ?? '';

    try {
      // Step 2: Fetch Data (Simulate Fetch All)
      // We request a large limit and empty filter to get the raw dataset
      // Strategy 1: "Simulate Fetch All" as per Architectural Decision
      final projectModels = await _remoteDataSource.getProjects(
        page: 1,
        limit: AppConstants.fetchAllLimit,
        filter: const ProjectFilterModel(),
      );

      var projects = projectModels.map((m) => m.toEntity()).toList();

      // Step 3: Filter Visibility
      projects = projects.where((p) => p.displayTier != DisplayTier.hidden).toList();

      // Step 4: Filter Technology
      if (filter.technology != null && filter.technology!.isNotEmpty) {
        final techFilter = filter.technology!.toLowerCase();
        projects = projects.where((p) {
          return p.technologies.any((t) => t.toLowerCase() == techFilter);
        }).toList();
      }

      // Step 5: Filter Search Query
      if (cleanQuery.isNotEmpty) {
        projects = projects.where((p) {
          final title = p.title.toLowerCase();
          final tagline = p.tagline.toLowerCase();
          final description = p.description.toLowerCase();
          return title.contains(cleanQuery) ||
              tagline.contains(cleanQuery) ||
              description.contains(cleanQuery);
        }).toList();
      }

      // Step 6: Sort: Tier-Preserving Strategy
      projects.sort((a, b) {
        // Primary Sort: DisplayTier
        // Hero (0) > Showcase (1) > Standard (2)
        // Enum index aligns: hero=0, showcase=1, standard=2.
        // Ascending index sort puts Hero first.
        final tierComparison = a.displayTier.index.compareTo(b.displayTier.index);
        if (tierComparison != 0) {
          return tierComparison;
        }

        // Secondary Sort: SortOrder
        // Newest/Popular: publishedAt Descending
        // Oldest: publishedAt Ascending
        final isAscending = filter.sortOrder == SortOrder.oldest;
        final dateComparison = isAscending
            ? a.publishedAt.compareTo(b.publishedAt)
            : b.publishedAt.compareTo(a.publishedAt); // Descending

        if (dateComparison != 0) {
          return dateComparison;
        }

        // Tie-Breaker: Alphabetical by ID
        return a.id.compareTo(b.id);
      });

      // Step 7: Paginate
      final startIndex = (cleanPage - 1) * cleanLimit;

      // Check: If startIndex >= filteredList.length, return an Empty List [].
      if (startIndex >= projects.length) {
        return const Right([]);
      }

      final endIndex = min(startIndex + cleanLimit, projects.length);
      final paginatedList = projects.sublist(startIndex, endIndex);

      // Step 8: Return
      return Right(paginatedList);
    } catch (e) {
      // All exceptions delegated to ErrorMapper per Protocol
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<Project> getProjectDetail(String projectId) async {
    // Step 1: Validate Input
    if (projectId.trim().isEmpty) {
      return const Left(
        ValidationFailure(
          message: 'Project ID cannot be empty',
          title: 'Invalid Input',
        ),
      );
    }

    try {
      // Step 2: Fetch Data
      final projectModel = await _remoteDataSource.getProjectDetail(projectId);

      // Step 4: Normalize & Return
      // Note: Normalization of optional lists (downloads, features) to ensure they are
      // non-null is handled by the ProjectModel's default values and toEntity() mapping.
      return Right(projectModel.toEntity());
    } catch (e) {
      // All exceptions delegated to ErrorMapper per Protocol
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }
}
