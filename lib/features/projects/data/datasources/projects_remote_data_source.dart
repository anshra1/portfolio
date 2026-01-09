// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portfolio/core/constants/asset_constants.dart';
import 'package:portfolio/core/error/error.dart';
import 'package:portfolio/core/services/talker_service.dart';
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

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  ProjectsRemoteDataSourceImpl({
    required this.assetBundle,
    required this.talkerService,
  });

  final AssetBundle assetBundle;
  final TalkerService talkerService;
  static const _sourcePath = AssetConstants.projectsDbPath;

  // In-memory cache to prevent redundant file reading
  List<ProjectModel>? _cachedProjects;

  Future<List<ProjectModel>> _getAllProjects() async {
    if (_cachedProjects != null) return _cachedProjects!;

    try {
      final jsonString = await assetBundle.loadString(_sourcePath);
      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      _cachedProjects = jsonList.map((item) {
        try {
          final projectMap = item as Map<String, dynamic>;
          return ProjectModel.fromJson(projectMap);
        } on Object catch (e) {
          // 'on Object' guarantees we catch TypeErrors (like Null subtypes)
          // and other runtime Errors that might slip past a bare catch 
          // in strict contexts.
          talkerService.warning('Skipping invalid project: $e');
          return null;
        }
      })
      .whereType<ProjectModel>()
      .toList();

      return _cachedProjects!;
    } on FormatException catch (e) {
      throw DataParsingException(
        methodName: 'getProjects',
        originalError: e.toString(),
        title: 'JSON Format Error',
        userMessage: 'Projects data is malformed',
      );
    } catch (e) {
      if (e is DataParsingException) rethrow;
      throw DataParsingException(
        methodName: 'getProjects',
        originalError: e.toString(),
        title: 'Unexpected Exception',
        userMessage: 'An error occurred while fetching projects',
      );
    }
  }

  @override
  Future<List<ProjectModel>> getProjects({
    required int page,
    required ProjectFilterModel filter,
    int? limit,
  }) async {
    var projects = await _getAllProjects();

    // 1. Filter by Search Query
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      final query = filter.searchQuery!.toLowerCase();
      projects = projects.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query);
      }).toList();
    }

    // 2. Filter by Technology
    if (filter.technology != null && filter.technology!.isNotEmpty) {
      final techQuery = filter.technology!.toLowerCase();
      projects = projects.where((p) {
        return p.technologies.any((t) => t.toLowerCase() == techQuery);
      }).toList();
    }

    // 3. Pagination
    if (limit != null) {
      final startIndex = (page - 1) * limit;
      if (startIndex >= projects.length) return [];

      projects = projects.skip(startIndex).take(limit).toList();
    }

    return projects;
  }

  @override
  Future<ProjectModel> getProjectDetail(String projectId) async {
    try {
      final projects = await _getAllProjects();
      
      // RELAXED CONTRACT: We only search the "valid" cached list.
      // If a project is corrupt, it was skipped during _getAllProjects,
      // so we simply throw NotFoundException here.
      return projects.firstWhere(
        (p) => p.id == projectId,
        orElse: () => throw NotFoundException(
          methodName: 'getProjectDetail',
          originalError: 'Project with ID $projectId not found',
          title: 'Project Not Found',
          userMessage: 'The requested project could not be found',
          context: {'projectId': projectId},
        ),
      );
    } catch (e) {
      if (e is NotFoundException || e is DataParsingException) rethrow;
      throw DataParsingException(
        methodName: 'getProjectDetail',
        originalError: e.toString(),
        title: 'Unexpected Exception',
        userMessage: 'An error occurred while fetching project details',
      );
    }
  }
}